// Code your testbench here
// or browse Examples
class transaction extends uvm_sequence_item;
  bit rst;
  rand logic [`addr_width-1:0] awaddr, araddr,switch;
  rand logic [2:0]awprot,arprot;
  rand logic [`data_width-1:0]wdata;
  rand logic awvalid,wvalid,arvalid;
  rand logic rready;
  rand logic [(`data_width/8)-1:0]wstrb;
  rand logic bready;
  logic awready,wready,arready;
  bit bvalid,rvalid;
  logic [1:0]bresp,rresp;
  logic [`data_width-1:0]rdata;
//   rand bit [2:0]write;
//   rand bit [2:0]read;
//   rand int cycles;
  rand logic [1:0]order;
  rand bit delay;
  rand bit fast;
  

  `uvm_object_utils_begin(transaction)
  `uvm_field_int(rst,UVM_ALL_ON)
  `uvm_field_int(awaddr,UVM_ALL_ON)
  `uvm_field_int(araddr,UVM_ALL_ON)
  `uvm_field_int(awprot,UVM_ALL_ON)
  `uvm_field_int(arprot,UVM_ALL_ON)
  `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_field_int(awvalid,UVM_ALL_ON)
  `uvm_field_int(wvalid,UVM_ALL_ON)
  `uvm_field_int(arvalid,UVM_ALL_ON)
  `uvm_field_int(rready,UVM_ALL_ON)
  `uvm_field_int(wstrb,UVM_ALL_ON)
  `uvm_field_int(bready,UVM_ALL_ON)
  `uvm_field_int(awready,UVM_ALL_ON)
  `uvm_field_int(wready,UVM_ALL_ON)
  `uvm_field_int(bvalid,UVM_ALL_ON)
  `uvm_field_int(arready,UVM_ALL_ON)
  `uvm_field_int(rvalid,UVM_ALL_ON)
  `uvm_field_int(bresp,UVM_ALL_ON)
  `uvm_field_int(rresp,UVM_ALL_ON)
  `uvm_field_int(rdata,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="transaction");
    super.new(name);
  endfunction
  
  constraint c{
    order!=0;

    soft fast==0;
  }


endclass
