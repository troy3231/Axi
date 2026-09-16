`include "package.sv"
`include "interface.sv"
module top;
  import uvm_pkg::*;
  import pkg::*;

  bit clk;
  bit rst_n; 

  initial begin 
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin 
    rst_n = 0;      
    #15 rst_n = 1;  
  end

  axi vif(clk, rst_n);
  
  axi4_lite_slave #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(32),
    .MEM_DEPTH(16)
  ) dut (
    .ACLK    (clk),
    .ARESETn (rst_n),
    
    .AWADDR  (vif.awaddr),
    .AWPROT  (vif.awprot),
    .AWVALID (vif.awvalid),
    .AWREADY (vif.awready),
    
    .WDATA   (vif.wdata),
    .WSTRB   (vif.wstrb),
    .WVALID  (vif.wvalid),
    .WREADY  (vif.wready),
    
    .BRESP   (vif.bresp),
    .BVALID  (vif.bvalid),
    .BREADY  (vif.bready),
    
    .ARADDR  (vif.araddr),
    .ARPROT  (vif.arprot),
    .ARVALID (vif.arvalid),
    .ARREADY (vif.arready),
    
    .RDATA   (vif.rdata),
    .RRESP   (vif.rresp),
    .RVALID  (vif.rvalid),
    .RREADY  (vif.rready)
  );
                
  initial begin
    uvm_config_db#(virtual axi)::set(null, "*", "vif", vif);
    run_test("test");
  end
  
  initial begin 
    $dumpfile("waveform.vcd"); 
    $dumpvars(0, top);   
  end
endmodule