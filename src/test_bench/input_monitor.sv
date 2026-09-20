class input_monitor extends uvm_monitor;
  `uvm_component_utils(input_monitor)
  virtual axi vif;
  uvm_analysis_port#(transaction) ap_write;
  uvm_analysis_port#(transaction) ap_read;
  bit rd;

  function new(string name="input_monitor", uvm_component parent);
    super.new(name,parent);
    ap_write=new("ap_write",this);
    ap_read=new("ap_read",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi)::get(this,"","vif",vif)) begin
      `uvm_fatal("INPUT_MONITOR","Didn't get interface")
    end
  endfunction

  task run_phase(uvm_phase phase);
    wait(vif.rst==1);
    fork
      monitor_writes();
      monitor_reads();
    join
  endtask

  task monitor_writes();
    transaction wr_tr;
    time aw_t,w_t;
    forever begin
      wr_tr=transaction::type_id::create("wr_tr");
      aw_t=0;
      w_t=0;
      fork
        begin
          do begin
            @(vif.im);
          end while(!(vif.im.awvalid==1&&vif.im.awready==1));
          rd=1;
          aw_t=$time;
          wr_tr.awaddr=vif.im.awaddr;
          wr_tr.awprot=vif.im.awprot;
        end
        begin
          do begin
            @(vif.im);
          end while(!(vif.im.wvalid==1&&vif.im.wready==1));
          w_t=$time;
          wr_tr.wdata=vif.im.wdata;
          wr_tr.wstrb=vif.im.wstrb;
        end
      join
      
      wr_tr.order=(aw_t<=w_t)?1:2;

      do begin
        @(vif.im);
      end while(!(vif.im.bready==1&&vif.im.bvalid==1));
      rd=0;
      ap_write.write(wr_tr);
    end
  endtask

  task monitor_reads();
    transaction rd_tr;
    forever begin
      rd_tr=transaction::type_id::create("rd_tr");
      do begin
        @(vif.im);
      end while(!(vif.im.arvalid==1&&vif.im.arready==1));
      rd_tr.araddr=vif.im.araddr;
      rd_tr.arprot=vif.im.arprot;
      do begin
        @(vif.im);
      end while(!(vif.im.rready==1&&vif.im.rvalid==1));
      ap_read.write(rd_tr);
    end
  endtask
endclass
