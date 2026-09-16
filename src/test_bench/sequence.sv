class write extends uvm_sequence#(transaction);
  // simultaneous awvalid and wvalid doesnt work 
  `uvm_object_utils(write)
  function new(string name="write");
    super.new(name);
  endfunction 
  
  
  task body();
    `uvm_info("WRITE","Writing",UVM_LOW)
    repeat(60) begin 
      `uvm_do_with(req,{delay inside{[1:12]};order==1;awaddr[1:0]==0;awaddr inside {[0:36],[52:56],60};})
    end
    `uvm_info("WRITE","Writing",UVM_LOW)
    repeat(500) begin
      `uvm_do_with(req,{delay inside{[1:12]};order==2;awaddr[1:0]==0;awaddr inside {[0:36],[52:56],60};fast==0;})
    end
   
    repeat(12)begin 
      `uvm_do_with(req,{delay inside{[1:12]};order==1;awaddr[1:0]==0;awaddr inside {[0:36],[52:56],60};wstrb==15;fast==0;})
    end
    `uvm_info("WRITE","Break",UVM_LOW)
     repeat(12)begin 
      `uvm_do_with(req,{delay inside{[1:12]};order==1;awaddr[1:0]==0;awaddr inside {[0:36],[52:56],60};wstrb==15;fast==1;switch inside {[0:36]};})
    end
    
    repeat(12)begin 
      `uvm_do_with(req,{delay inside{[1:12]};order==2;awaddr>60;})
    end
//     `uvm_info("WRITE","Writing",UVM_LOW)
//     repeat(12)begin 
//       `uvm_do_with(req,{delay inside{[1:12]};order==2;awaddr[1:0]==0;!(awaddr inside {[0:36],[52:56],60});})
//       `uvm_info("WRITE","Writing",UVM_LOW)
    
//     end
       
    repeat(12) begin
      `uvm_do_with(req,{delay inside{[1:12]};order==1;awaddr[1:0]!=0;awaddr inside{[0:36],[52:56],60};})
    end
    
    repeat(12) begin
      `uvm_do_with(req,{delay inside{[1:12]};order==1;awaddr[1:0]==0;awaddr inside{[40:48]};})
    end
    
        repeat(12) begin
      `uvm_do_with(req,{delay inside{[1:12]};order==1;awaddr[1:0]==0;awaddr inside{[0:36]};wstrb==0;})
    end


  endtask 
endclass


class read extends uvm_sequence#(transaction);
  `uvm_object_utils(read)
  function new(string name="read");
    super.new(name);
  endfunction 
  task body();
    repeat(25) begin 
      `uvm_do_with(req,{delay inside{[1:12]};order==1;araddr[1:0]==0;araddr inside {[0:36],[40:48],60};})
    end
    repeat(25) begin
      `uvm_do_with(req,{delay inside{[1:12]};order==2;araddr[1:0]==0;araddr inside {[0:36],[40:48],60};})
    end 
    repeat(50)begin 
      `uvm_do_with(req,{delay inside{[1:12]};order==3;araddr[1:0]==0;araddr inside {[0:36],[40:48],60};})
    end
    repeat(40)begin 
      `uvm_do_with(req,{delay inside{[1:12]};order==3;araddr[1:0]!=0;})
    end
    repeat(40)begin 
      
      `uvm_do_with(req,{delay inside{[1:12]};order==3;araddr[1:0]==0;!(araddr inside {[0:36],[40:48],60});})
      
    end
        repeat(20) begin
      `uvm_do_with(req,{delay inside{[1:12]};order==1;araddr[1:0]==0;araddr inside{[52:56]};})
    end

  endtask 
endclass 


class simul extends uvm_sequence;
  `uvm_object_utils(simul)
 
  uvm_sequencer#(transaction) wr_sqr;
  uvm_sequencer#(transaction) rd_sqr;
  transaction wr;
  transaction rd;
  function new(string name="simul");
    super.new(name);
  endfunction 
  
  bit[31:0]mask=32'hFFFFFFFC;
  
  task body();
    int addr;
    transaction req;
    `uvm_info("SEQ","Write only",UVM_LOW)
    `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr==0;})
    repeat(20) begin 
      
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr[1:0]==0;awaddr inside {[0:36],[52:56],60};})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
    `uvm_info("SEQ","Write at unaligned",UVM_LOW)
    repeat(20) begin 
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr[1:0]!=0;awaddr inside {[0:36],[52:56],60};})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
    `uvm_info("SEQ","Write at unaligned read at aligned",UVM_LOW)
    repeat(20) begin 
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr[1:0]!=0;awaddr inside {[0:36],[52:56],60};})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==(addr&mask);})
    end
    `uvm_info("SEQ","Read at unaligned write at aligned  ",UVM_LOW)
    repeat(20) begin 
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr[1:0]!=0;araddr inside {[0:36],[40:48],60};})
      addr=req.araddr;
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr==(addr&mask);})
    end
    `uvm_info("SEQ","write at Read only",UVM_LOW)
    repeat(40) begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr inside {[40:48]};awaddr[1:0]==0;})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
    `uvm_info("SEQ","Read at write only  at Read only",UVM_LOW)
    repeat(50) begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;awaddr inside {[52:56]};awaddr[1:0]==0;})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
    repeat(50) begin
      `uvm_do_on_with(req,wr_sqr,{delay inside{[1:12]};order==1;!(awaddr inside {[0:36],[40:48],[52:56],60});})
      addr=req.awaddr;
      `uvm_do_on_with(req,rd_sqr,{delay inside{[1:12]};order==1;araddr==addr;})
    end
    
    
    // ssimultaneous read and write 
    
    `uvm_info("SQR","Driving both simultanously",UVM_LOW)

    repeat(20) begin 
      fork
        `uvm_do_on_with(wr,wr_sqr,{delay==1;order==2;awaddr[1:0]==0;awaddr inside {[0:36],60};})
        `uvm_do_on_with(rd,rd_sqr,{delay==0;order==1;araddr[1:0]==0;araddr inside {[0:36],60};})
      join
    end
    
    `uvm_info("SQR","Driving both simultanously to the SAME address",UVM_LOW)

    repeat(50) begin
      if (!std::randomize(addr)with {addr[1:0]==0;addr inside {[0:36],60};}) begin
        `uvm_error("SQR", "Failed to randomize addr")
      end
      
    
      fork
        `uvm_do_on_with(wr,wr_sqr,{delay==1;order==2;awaddr==addr;})
        `uvm_do_on_with(rd, rd_sqr,{delay==0;order==1;araddr==addr;})
      join
    end
    
    `uvm_info("SQR","end",UVM_LOW)
  endtask
endclass