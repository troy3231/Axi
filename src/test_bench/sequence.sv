class tc02_write extends uvm_sequence#(transaction);
  `uvm_object_utils(tc02_write)
  function new(string name="tc02_write");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
    end
  endtask
endclass

class tc03_aw_first extends uvm_sequence#(transaction);
  `uvm_object_utils(tc03_aw_first)
  function new(string name="tc03_aw_first");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order==1;awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
    end
  endtask
endclass

class tc04_w_first extends uvm_sequence#(transaction);
  `uvm_object_utils(tc04_w_first)
  function new(string name="tc04_w_first");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order==2;awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
    end
  endtask
endclass

class tc06_wstrb extends uvm_sequence#(transaction);
  `uvm_object_utils(tc06_wstrb)
  function new(string name="tc06_wstrb");
    super.new(name);
  endfunction
  task body();
    repeat(40)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb inside{[0:15]};fast==0;})
    end
  endtask
endclass

class tc07_wr_unaligned extends uvm_sequence#(transaction);
  `uvm_object_utils(tc07_wr_unaligned)
  function new(string name="tc07_wr_unaligned");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]!=0;awaddr inside{[0:36],[52:56],60};})
    end
  endtask
endclass

class tc08_wr_ro extends uvm_sequence#(transaction);
  `uvm_object_utils(tc08_wr_ro)
  function new(string name="tc08_wr_ro");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]==0;awaddr inside{[40:48]};})
    end
  endtask
endclass

class tc09_wr_oor extends uvm_sequence#(transaction);
  `uvm_object_utils(tc09_wr_oor)
  function new(string name="tc09_wr_oor");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};awaddr>60;})
    end
  endtask
endclass

class tc10_stall_w extends uvm_sequence#(transaction);
  `uvm_object_utils(tc10_stall_w)
  function new(string name="tc10_stall_w");
    super.new(name);
  endfunction
  task body();
    repeat(20)begin
      `uvm_do_with(req,{delay inside{[8:12]};order==1;awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
    end
  endtask
endclass

class tc11_stall_aw extends uvm_sequence#(transaction);
  `uvm_object_utils(tc11_stall_aw)
  function new(string name="tc11_stall_aw");
    super.new(name);
  endfunction
  task body();
    repeat(20)begin
      `uvm_do_with(req,{delay inside{[8:12]};order==2;awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
    end
  endtask
endclass

class tc12_stall_bready extends uvm_sequence#(transaction);
  `uvm_object_utils(tc12_stall_bready)
  function new(string name="tc12_stall_bready");
    super.new(name);
  endfunction
  task body();
    repeat(20)begin
      `uvm_do_with(req,{delay inside{[8:12]};order inside{1,2};awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
    end
  endtask
endclass

class tc13_b2b_wr_aligned extends uvm_sequence#(transaction);
  `uvm_object_utils(tc13_b2b_wr_aligned)
  function new(string name="tc13_b2b_wr_aligned");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
    end
  endtask
endclass

class tc14_b2b_wr_unaligned extends uvm_sequence#(transaction);
  `uvm_object_utils(tc14_b2b_wr_unaligned)
  function new(string name="tc14_b2b_wr_unaligned");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]!=0;awaddr inside{[0:36],[52:56],60};})
    end
  endtask
endclass

class tc15_read extends uvm_sequence#(transaction);
  `uvm_object_utils(tc15_read)
  function new(string name="tc15_read");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};araddr[1:0]==0;araddr inside{[0:36],[40:48],60};})
    end
  endtask
endclass

class tc16_read_rand_strb extends uvm_sequence#(transaction);
  `uvm_object_utils(tc16_read_rand_strb)
  function new(string name="tc16_read_rand_strb");
    super.new(name);
  endfunction
  task body();
    repeat(20)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};araddr[1:0]==0;araddr inside{[0:36],[40:48],60};wstrb inside{[0:15]};})
    end
  endtask
endclass

class tc17_rd_unaligned extends uvm_sequence#(transaction);
  `uvm_object_utils(tc17_rd_unaligned)
  function new(string name="tc17_rd_unaligned");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};araddr[1:0]!=0;})
    end
  endtask
endclass

class tc18_rd_wo extends uvm_sequence#(transaction);
  `uvm_object_utils(tc18_rd_wo)
  function new(string name="tc18_rd_wo");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};araddr[1:0]==0;araddr inside{[52:56]};})
    end
  endtask
endclass

class tc19_rd_oor extends uvm_sequence#(transaction);
  `uvm_object_utils(tc19_rd_oor)
  function new(string name="tc19_rd_oor");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};araddr[1:0]==0;!(araddr inside{[0:36],[40:48],[52:56],60});})
    end
  endtask
endclass

class tc20_stall_rready extends uvm_sequence#(transaction);
  `uvm_object_utils(tc20_stall_rready)
  function new(string name="tc20_stall_rready");
    super.new(name);
  endfunction
  task body();
    repeat(20)begin
      `uvm_do_with(req,{delay inside{[8:12]};order inside{1,2};araddr[1:0]==0;araddr inside{[0:36],[40:48],60};})
    end
  endtask
endclass

class tc21_b2b_rd_aligned extends uvm_sequence#(transaction);
  `uvm_object_utils(tc21_b2b_rd_aligned)
  function new(string name="tc21_b2b_rd_aligned");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};araddr[1:0]==0;araddr inside{[0:36],[40:48],60};})
    end
  endtask
endclass

class tc22_b2b_rd_unaligned extends uvm_sequence#(transaction);
  `uvm_object_utils(tc22_b2b_rd_unaligned)
  function new(string name="tc22_b2b_rd_unaligned");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};araddr[1:0]!=0;})
    end
  endtask
endclass

class tc23_b2b_rd_wo extends uvm_sequence#(transaction);
  `uvm_object_utils(tc23_b2b_rd_wo)
  function new(string name="tc23_b2b_rd_wo");
    super.new(name);
  endfunction
  task body();
    repeat(30)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};araddr[1:0]==0;araddr inside{[52:56]};})
    end
  endtask
endclass

class tc24_wr_rd_same_aligned extends uvm_sequence;
  `uvm_object_utils(tc24_wr_rd_same_aligned)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc24_wr_rd_same_aligned");
    super.new(name);
  endfunction
  task body();
    transaction req;
    int addr;
    repeat(30)begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb inside{[0:15]};})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
  endtask
endclass

class tc25_wr_rd_same_unaligned extends uvm_sequence;
  `uvm_object_utils(tc25_wr_rd_same_unaligned)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc25_wr_rd_same_unaligned");
    super.new(name);
  endfunction
  task body();
    transaction req;
    int addr;
    repeat(30)begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr[1:0]!=0;awaddr inside{[0:36],[52:56],60};})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
  endtask
endclass

class tc26_par_rd_wr extends uvm_sequence;
  `uvm_object_utils(tc26_par_rd_wr)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc26_par_rd_wr");
    super.new(name);
  endfunction
  task body();
    transaction wr,rd;
    repeat(20) begin
      fork
        `uvm_do_on_with(wr,wr_sqr,{delay==1;order==2;awaddr[1:0]==0;awaddr inside {0,4,8};})
        `uvm_do_on_with(rd,rd_sqr,{delay==0;order==1;araddr[1:0]==0;araddr inside {0,4,8};})
      join
    end
  endtask
endclass

class tc27_wr_ro_rd_ro extends uvm_sequence;
  `uvm_object_utils(tc27_wr_ro_rd_ro)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc27_wr_ro_rd_ro");
    super.new(name);
  endfunction
  task body();
    transaction req;
    int addr;
    repeat(40)begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr inside {[40:48]};awaddr[1:0]==0;})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
  endtask
endclass

class tc28_wr_wo_rd_wo extends uvm_sequence;
  `uvm_object_utils(tc28_wr_wo_rd_wo)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc28_wr_wo_rd_wo");
    super.new(name);
  endfunction
  task body();
    transaction req;
    int addr;
    repeat(50)begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr inside {[52:56]};awaddr[1:0]==0;})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
  endtask
endclass

class tc29_wr_rd_unaligned extends uvm_sequence;
  `uvm_object_utils(tc29_wr_rd_unaligned)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc29_wr_rd_unaligned");
    super.new(name);
  endfunction
  task body();
    transaction req;
    int addr;
    repeat(20) begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr[1:0]!=0;awaddr inside {[0:36],[52:56],60};})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
  endtask
endclass

class tc30_wr_unaligned_rd_aligned extends uvm_sequence;
  `uvm_object_utils(tc30_wr_unaligned_rd_aligned)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  bit[31:0]mask=32'hFFFFFFFC;
  function new(string name="tc30_wr_unaligned_rd_aligned");
    super.new(name);
  endfunction
  task body();
    transaction req;
    int addr;
    repeat(20) begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr[1:0]!=0;awaddr inside {[0:36],[52:56],60};})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==(addr&mask);})
    end
  endtask
endclass

class tc31_rd_unaligned_wr_aligned extends uvm_sequence;
  `uvm_object_utils(tc31_rd_unaligned_wr_aligned)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  bit[31:0]mask=32'hFFFFFFFC;
  function new(string name="tc31_rd_unaligned_wr_aligned");
    super.new(name);
  endfunction
  task body();
    transaction req;
    int addr;
    repeat(20) begin
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr[1:0]!=0;araddr inside {[0:36],[40:48],60};})
      addr=req.araddr;
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr==(addr&mask);})
    end
  endtask
endclass

class tc32_wr_rd_oor extends uvm_sequence;
  `uvm_object_utils(tc32_wr_rd_oor)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc32_wr_rd_oor");
    super.new(name);
  endfunction
  task body();
    transaction req;
    int addr;
    repeat(50) begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;!(awaddr inside {[0:36],[40:48],[52:56],60});})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
  endtask
endclass

class tc33_par_bready_stall extends uvm_sequence;
  `uvm_object_utils(tc33_par_bready_stall)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc33_par_bready_stall");
    super.new(name);
  endfunction
  task body();
    transaction wr,rd;
    repeat(20) begin
      fork
        `uvm_do_on_with(wr,wr_sqr,{delay inside{[8:12]};order==1;awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
        `uvm_do_on_with(rd,rd_sqr,{delay inside{[1:4]};order==1;araddr[1:0]==0;araddr inside{[0:36],[40:48],60};})
    join
    end
  endtask
endclass

class tc34_par_rready_stall extends uvm_sequence;
  `uvm_object_utils(tc34_par_rready_stall)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc34_par_rready_stall");
    super.new(name);
  endfunction
  task body();
    transaction wr,rd;
    repeat(20) begin
      fork
        `uvm_do_on_with(wr,wr_sqr,{delay inside{[1:4]};order==1;awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
        `uvm_do_on_with(rd,rd_sqr,{delay inside{[8:12]};order==1;araddr[1:0]==0;araddr inside{[0:36],[40:48],60};})
      join
    end
  endtask
endclass

class tc35_write_at_unaligned extends uvm_sequence#(transaction);
  `uvm_object_utils(tc35_write_at_unaligned)
  function new(string name="tc35_write_at_unaligned");
    super.new(name);
  endfunction
//   `uvm_info("SEQ","Writing at unaligned",UVM_LOW)
  task body();
    repeat(200)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]==0;awaddr>64;wstrb==15;fast==0;})
    end
  endtask
endclass


class tc36_order_closure extends uvm_sequence#(transaction);
  `uvm_object_utils(tc36_order_closure)
  function new(string name="tc36_order_closure");
    super.new(name);
  endfunction
  task body();
    repeat(20)begin
      `uvm_do_with(req,{delay inside{[1:12]};order==1;awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
    end
    repeat(20)begin
      `uvm_do_with(req,{delay inside{[1:12]};order==2;awaddr[1:0]==0;awaddr inside{[0:36],[52:56],60};wstrb==15;fast==0;})
    end
  endtask
endclass


class tc37_wr_ro_unaligned extends uvm_sequence#(transaction);
  `uvm_object_utils(tc37_wr_ro_unaligned)
  function new(string name="tc37_wr_ro_unaligned");
    super.new(name);
  endfunction
  task body();
    repeat(20)begin
      `uvm_do_with(req,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]!=0;awaddr inside{[40:48]};wstrb==15;fast==0;})
    end
  endtask
endclass


class tc38_rw_region_gap_closure extends uvm_sequence;
  `uvm_object_utils(tc38_rw_region_gap_closure)
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  function new(string name="tc38_rw_region_gap_closure");
    super.new(name);
  endfunction
  task body();
    transaction req;

    // (oor,wo) : write OOR, then read WO
    repeat(10)begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order inside{1,2};awaddr>60;wstrb==15;fast==0;})
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};araddr[1:0]==0;araddr inside{[52:56]};})
    end

    // (wo,oor) : write WO, then read OOR
    repeat(10)begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]==0;awaddr inside{[52:56]};wstrb==15;fast==0;})
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};araddr>60;})
    end

    // (ro,oor) : write RO, then read OOR
    repeat(10)begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]==0;awaddr inside{[40:48]};wstrb==15;fast==0;})
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};araddr>60;})
    end

    // (ro,wo) : write RO, then read WO
    repeat(10)begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order inside{1,2};awaddr[1:0]==0;awaddr inside{[40:48]};wstrb==15;fast==0;})
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};araddr[1:0]==0;araddr inside{[52:56]};})
    end
  endtask
endclass
