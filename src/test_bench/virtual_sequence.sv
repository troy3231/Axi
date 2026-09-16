class virtual_sequence extends uvm_sequence;
  `uvm_object_utils(virtual_sequence)
  `uvm_declare_p_sequencer(virtual_seqr)
  write wr;
  read rd;
  simul sim;

  function new(string name="virtual_sequence");
    super.new(name);
  endfunction

  task body();
    `uvm_info(get_type_name(),"Starting virtual sequence",UVM_LOW)

    wr=write::type_id::create("wr");
    wr.start(p_sequencer.wr_seqr);
    
    rd=read::type_id::create("rd");
    rd.start(p_sequencer.rd_seqr);
    
    sim = simul::type_id::create("sim");
sim.wr_sqr = p_sequencer.wr_seqr; 
sim.rd_sqr = p_sequencer.rd_seqr; 
sim.start(null);
    `uvm_info(get_type_name(),"Virtual sequence completed",UVM_LOW)
  endtask
endclass