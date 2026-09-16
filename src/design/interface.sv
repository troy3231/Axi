interface axi(input logic clk, input logic rst);
  // Address Write Channel
  logic [`addr_width-1:0] awaddr;
  logic [2:0] awprot;
  logic awvalid;
  logic awready;
  
  // Write Data Channel
  logic [`data_width-1:0] wdata;
  logic [(`data_width/8)-1:0] wstrb;
  logic wvalid;
  logic wready;
  
  // Write Response Channel
  logic [1:0] bresp;
  logic bvalid;
  logic bready;
  
  // Address Read Channel
  logic [`addr_width-1:0] araddr;
  logic [2:0] arprot;
  logic arvalid;
  logic arready;
  
  // Read Data Channel
  logic [`data_width-1:0] rdata;
  logic [1:0] rresp;
  logic rvalid;
  logic rready;

  clocking drv @(posedge clk);
    default input #1step output #1;
    output awaddr, awprot, awvalid;
    output wdata, wstrb, wvalid;
    output bready;
    output araddr, arprot, arvalid;
    output rready;
    input awready, wready, bresp, bvalid, arready, rdata, rresp, rvalid;
  endclocking

  clocking im @(posedge clk);
    default input #1step output #0;
    input awvalid, awready, awaddr, awprot;
    input wvalid, wready, wdata, wstrb;
    input bvalid, bready;
    input arvalid, arready, araddr, arprot;
    input rvalid, rready;
  endclocking

  clocking om @(posedge clk);
    default input #1step output #0;
    input bvalid, bready, bresp;
    input rvalid, rready, rdata, rresp;
  endclocking
  
  property p1;
  @(posedge clk)(!rst)|->(awready==0)&&(wready==0)&&(arready==0)&&(bvalid==0)&&(rvalid==0)&&(bresp==0)&&(rresp==0)&&(rdata==0);
  endproperty
  assert property(p1);
    
  property p_rdata_latch;
  @(posedge clk) disable iff (!rst)
    (!(rvalid))|->$stable(rdata);
endproperty
assert property (p_rdata_latch);
  
  property p_bvalid;
    @(posedge clk) disable iff (!rst)
      (bvalid && !bready) |=> bvalid;
  endproperty
  assert property (p_bvalid)
    else $error("BVALID dropped before BREADY handshake");
 
  property pbresp;
    @(posedge clk) disable iff (!rst)
      (bvalid && !bready) |=> $stable(bresp);
  endproperty
    assert property (pbresp)
    else $error("BRESP changed while waiting for BREADY");

endinterface