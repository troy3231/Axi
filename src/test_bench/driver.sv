class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)
  uvm_seq_item_pull_port#(transaction) wr;
  uvm_seq_item_pull_port#(transaction) rd;
  virtual axi vif;
  function new(string name="driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi)::get(this,"","vif",vif))`uvm_fatal("DRV","Interface error")
    wr=new("wr",this);
    rd=new("rd",this);
  endfunction
  task run_phase(uvm_phase phase);
    reset_signals();
    wait(vif.rst==1);
    fork
      forever begin
        transaction wr_req;
        wr.get_next_item(wr_req);
        fork
          w_addr(wr_req);
          w_data(wr_req);
        join
        w_resp(wr_req);
        wr.item_done();
      end
      forever begin
        transaction rd_req;
        rd.get_next_item(rd_req);
        r_addr(rd_req);
        r_data(rd_req);
        rd.item_done();
      end
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
  
  task w_addr(transaction req);
    if(req.order==1) repeat(req.delay) @(vif.drv);
    @(vif.drv);
    vif.drv.awvalid<=1;
    vif.drv.awprot<=0; 
    vif.drv.awaddr<=req.awaddr;
    do @(vif.drv);
    while(vif.drv.awready!==1'b1);
    if(req.fast==1) begin 
      @(vif.drv);
      vif.drv.awaddr<=req.switch;
      repeat(4)@(vif.drv);
//        do @(vif.drv);
//     while(vif.drv.awready!==1'b1);
    end
    vif.drv.awvalid<=0;
  endtask
  
  task w_data(transaction req);
    if(req.order==2) repeat(req.delay) @(vif.drv);
    @(vif.drv);
    vif.drv.wvalid<=1;
    vif.drv.wdata<=req.wdata; 
    vif.drv.wstrb<=req.wstrb;
    do @(vif.drv);
    while(vif.drv.wready!==1'b1);
    vif.drv.wvalid<=0;
  endtask
  
  task w_resp(transaction req);
    repeat(req.delay) @(vif.drv);
    vif.drv.bready<=1;
    do @(vif.drv); 
    while(vif.drv.bvalid!==1'b1);
    vif.drv.bready<=0;
  endtask
  
  task r_addr(transaction req);
    @(vif.drv);
    vif.drv.araddr<=req.araddr; 
    vif.drv.arprot<=0; 
    vif.drv.arvalid<=1;
    do @(vif.drv);
    while(vif.drv.arready!==1'b1);
    vif.drv.arvalid<=0;
  endtask
  
  task r_data(transaction req);
    @(vif.drv);
    vif.drv.rready<=1;
    do @(vif.drv);
    while(vif.drv.rvalid!==1'b1);
    vif.drv.rready<=0;
  endtask
  
endclass