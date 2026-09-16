class virtual_seqr extends uvm_sequencer;
  `uvm_component_utils(virtual_seqr)
  sequencer wr_seqr;
  sequencer rd_seqr;
  function new(string name="virtual_seqr",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass