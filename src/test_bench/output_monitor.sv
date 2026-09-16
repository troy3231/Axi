class output_monitor extends uvm_monitor;
  `uvm_component_utils(output_monitor)
  virtual axi vif;
  uvm_analysis_port#(transaction) ap;

  function new(string name="output_monitor", uvm_component parent);
    super.new(name,parent);
    ap=new("ap",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi)::get(this,"","vif",vif)) begin
      `uvm_fatal("OUTPUT_MONITOR","Didn't get interface")
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
    forever begin
      wr_tr=transaction::type_id::create("wr_tr");
      do begin
        @(vif.om);
      end while (!(vif.om.bvalid==1 && vif.om.bready==1));
      wr_tr.bresp=vif.om.bresp;
      wr_tr.bvalid=1;
      ap.write(wr_tr);
    end
  endtask

  task monitor_reads();
    transaction rd_tr;
    forever begin
      rd_tr=transaction::type_id::create("rd_tr");
      do begin
        @(vif.om);
      end while (!(vif.om.rvalid==1 && vif.om.rready==1));
      rd_tr.rdata=vif.om.rdata;
      rd_tr.rresp=vif.om.rresp;
      rd_tr.rvalid=1;
      ap.write(rd_tr);
    end
  endtask
endclass