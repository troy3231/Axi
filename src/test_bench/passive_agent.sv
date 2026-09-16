class passive_agent extends uvm_agent;
  `uvm_component_utils(passive_agent)
  output_monitor mon;
  function new(string name="passive_agent",uvm_component parent);
    super.new(name,parent);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    mon=output_monitor::type_id::create("mon",this);
    super.build_phase(phase);
  endfunction 
  
endclass