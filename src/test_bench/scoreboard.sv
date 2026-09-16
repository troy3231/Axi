`uvm_analysis_imp_decl(_axi_write)
`uvm_analysis_imp_decl(_axi_read)

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp_axi_write#(transaction,scoreboard) ap_write;
  uvm_analysis_imp_axi_read#(transaction,scoreboard) ap_read;
  uvm_tlm_analysis_fifo#(transaction) out;
  
  function new(string name="scoreboard", uvm_component parent);
    super.new(name,parent);
    ap_write=new("ap_write",this);
    ap_read=new("ap_read",this);
    out=new("out",this);
  endfunction

  transaction exp_wr[$];
  transaction exp_rd[$];
  bit [`data_width-1:0] mem[int];

  task run_phase(uvm_phase phase);
    transaction op, exp_tr;
    forever begin
      out.get(op);
      
      if(op.bvalid==1) begin
        if(exp_wr.size()>0) begin
          exp_tr=exp_wr.pop_front();
          if(op.bresp!=exp_tr.bresp) begin
            `uvm_error("SCB",$sformatf("Response mismatch Exp:%0d Act:%0d",exp_tr.bresp,op.bresp))
          end else `uvm_info("SCB","Write MATCH",UVM_HIGH)
        end else `uvm_error("SCB","Unexpected Write Response (queue empty)")
      end
      
      if(op.rvalid==1) begin
        if(exp_rd.size()>0) begin
          exp_tr=exp_rd.pop_front();
          if(op.rdata!=exp_tr.rdata) begin
            `uvm_error("SCB",$sformatf("Data mismatch Exp:%0h Act:%0h",exp_tr.rdata,op.rdata))
          end
          if(op.rresp!=exp_tr.rresp) begin
            `uvm_error("SCB",$sformatf("Response mismatch Exp:%0d Act:%0d",exp_tr.rresp,op.rresp))
          end
          if(op.rdata==exp_tr.rdata && op.rresp==exp_tr.rresp) `uvm_info("SCB","Read MATCH",UVM_HIGH)
        end else `uvm_error("SCB","Unexpected Read Response (queue empty)")
      end
    end
  endtask
virtual function void write_axi_write(transaction tr);
          transaction wr_exp=new();
          if(tr.awaddr==20) `uvm_info("SCB","wrote at 20",UVM_LOW)
  if(tr.awaddr>=64) begin
    wr_exp.bresp=3; // decerr

  end else if(tr.awaddr[1:0]!=2'b00) begin
    wr_exp.bresp=2; // slverr unaligned
  end else if(tr.awaddr>=40 && tr.awaddr<=48) begin
    wr_exp.bresp=2; // slverr read-only
  end else begin
    wr_exp.bresp=0;
    foreach(tr.wstrb[j]) begin
      if(tr.wstrb[j]) begin
        mem[tr.awaddr][j*8+:8]=tr.wdata[j*8+:8];
      end
    end
  end
  exp_wr.push_back(wr_exp);
endfunction

virtual function void write_axi_read(transaction tr);
  transaction rd_exp=new();
  if(tr.araddr>=64) begin
    rd_exp.rresp=3; // decerr
  end else if(tr.araddr[1:0]!=2'b00) begin
    rd_exp.rresp=2; // slverr unaligned
  end else if(tr.araddr>=52 && tr.araddr<=56) begin
    rd_exp.rresp=2; // slverr write-only
  end else begin
    rd_exp.rresp=0;
    if(mem.exists(tr.araddr)) begin
      rd_exp.rdata=mem[tr.araddr];
    end else begin
      rd_exp.rdata=0;
    end
  end
  exp_rd.push_back(rd_exp);
endfunction
          endclass 