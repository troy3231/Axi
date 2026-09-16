class active_agent extends uvm_agent;
  driver drv;
  sequencer wr_seqr;
  sequencer rd_seqr;
  input_monitor mon;
  `uvm_component_utils(active_agent)
  function new(string name="active_agent",uvm_component parent);
    super.new(name,parent);
  endfunction 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv=driver::type_id::create("drv",this);
    wr_seqr=sequencer::type_id::create("wr_seqr",this);
    rd_seqr=sequencer::type_id::create("rd_seqr",this);
    mon=input_monitor::type_id::create("mon",this);
  endfunction 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.wr.connect(wr_seqr.seq_item_export);
    drv.rd.connect(rd_seqr.seq_item_export);
  endfunction 
endclass