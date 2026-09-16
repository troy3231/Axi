class environment extends uvm_env;
  `uvm_component_utils(environment)
  scoreboard sb;
  active_agent act;
  passive_agent pas;
  virtual_seqr vseqr;
  subscriber sbr;
  function new(string name="environment", uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb=scoreboard::type_id::create("sb",this);
    act=active_agent::type_id::create("act",this);
    pas=passive_agent::type_id::create("pas",this);
    vseqr=virtual_seqr::type_id::create("vseqr",this);
    sbr=subscriber::type_id::create("sbr",this);
  endfunction
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    act.mon.ap_write.connect(sb.ap_write);
    act.mon.ap_read.connect(sb.ap_read);
    pas.mon.ap.connect(sb.out.analysis_export);
    act.mon.ap_write.connect(sbr.ap_write);
    act.mon.ap_read.connect(sbr.ap_read);
    vseqr.wr_seqr=act.wr_seqr;
    vseqr.rd_seqr=act.rd_seqr;
  endfunction
endclass