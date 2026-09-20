
class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)

  
  uvm_seq_item_pull_port#(transaction) wr;
  uvm_seq_item_pull_port#(transaction) rd;
  virtual axi vif;

  function new(string name="driver", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Interface error")
    wr=new("wr",this);
    rd=new("rd",this);
  endfunction

  task run_phase(uvm_phase phase);
    reset_signals();
    wait(vif.rst==1);
    @(vif.drv);
    fork
      write_loop();
      read_loop();
    join
  endtask

  task reset_signals();
    vif.drv.awvalid<=0;
    vif.drv.wvalid<=0;
    vif.drv.bready<=0;
    vif.drv.arvalid<=0;
    vif.drv.rready<=0;
    vif.drv.awaddr<=0;
    vif.drv.wdata<=0;
    vif.drv.wstrb<=0;
    vif.drv.araddr<=0;
    vif.drv.awprot<=0;
    vif.drv.arprot<=0;
  endtask

  function int unsigned lead(transaction req);
    return ((req.delay%4)==0)?0:req.delay;
  endfunction

  task write_loop();
    forever begin
      transaction req;
      int unsigned gap;
      wr.get_next_item(req);
      gap=req.delay%3;

      if(req.order==1) begin
        w_data(req,lead(req));
        repeat(gap) @(vif.drv);
        w_addr(req,0);
      end
      else begin
        w_addr(req,lead(req));
        repeat(gap) @(vif.drv);
        w_data(req,0);
      end

      w_resp(req);
      wr.item_done();
    end
  endtask

  task w_addr(transaction req, int unsigned pre);
    repeat(pre) @(vif.drv);
    vif.drv.awvalid<=1'b1;
    vif.drv.awaddr<=req.awaddr;
    vif.drv.awprot<=$urandom_range(0,7);
    do @(vif.drv);
    while(vif.drv.awready!==1'b1);
    vif.drv.awvalid<=1'b0;
    if(req.fast==1) vif.drv.awaddr<=req.switch;
  endtask

  task w_data(transaction req, int unsigned pre);
    repeat(pre) @(vif.drv);
    vif.drv.wvalid<=1'b1;
    vif.drv.wdata<=req.wdata;
    vif.drv.wstrb<=req.wstrb;
    do @(vif.drv);
    while(vif.drv.wready!==1'b1);
    vif.drv.wvalid<=1'b0;
  endtask

  task w_resp(transaction req);
    if(req.delay%2) begin
      vif.drv.bready<=1'b1;
    end
    else begin
      repeat(req.delay) @(vif.drv);
      vif.drv.bready<=1'b1;
    end
    do @(vif.drv);
    while(vif.drv.bvalid!==1'b1);
    vif.drv.bready<=1'b0;
  endtask

  task read_loop();
    forever begin
      transaction req;
      rd.get_next_item(req);
      r_addr(req,((req.delay%4)==0)?0:1);
      r_data(req);
      rd.item_done();
    end
  endtask

  task r_addr(transaction req, int unsigned pre);
    repeat(pre) @(vif.drv);
    vif.drv.araddr<=req.araddr;
    vif.drv.arprot<=$urandom_range(0,7);
    vif.drv.arvalid<=1'b1;
    do @(vif.drv);
    while(vif.drv.arready!==1'b1);
    vif.drv.arvalid<=1'b0;
  endtask

  task r_data(transaction req);
    if(req.delay%3) repeat(req.delay) @(vif.drv);
    vif.drv.rready<=1'b1;
    do @(vif.drv);
    while(vif.drv.rvalid!==1'b1);
    vif.drv.rready<=1'b0;
  endtask

endclass
