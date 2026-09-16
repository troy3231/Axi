`uvm_analysis_imp_decl(_write)
`uvm_analysis_imp_decl(_read)

class subscriber extends uvm_component;
  `uvm_component_utils(subscriber)

  transaction wr_tr;
  transaction rd_tr;

  uvm_analysis_imp_write#(transaction,subscriber) ap_write;
  uvm_analysis_imp_read#(transaction,subscriber) ap_read;

  covergroup cg;
    cp_wr_region:coverpoint wr_tr.awaddr{
      bins rw={[0:36],60};
      bins ro={[40:48]};
      bins wo={[52:56]};
      bins oor={[64:$]};
    }
    cp_wr_align:coverpoint wr_tr.awaddr[1:0]{
      bins aligned={0};
      bins unaligned={[1:3]};
    }
    cp_wstrb:coverpoint wr_tr.wstrb{
      bins full={15};
      bins partial={[1:14]};
      bins none={0};
    }
    cp_wstrb_all:coverpoint wr_tr.wstrb{
      bins b[]={[0:15]};
    }
  
    cp_wr_order:coverpoint wr_tr.order{
      bins aw_first={1};
      bins w_first={2};
    }

    cp_rd_region:coverpoint rd_tr.araddr{
      bins rw={[0:36],60};
      bins ro={[40:48]};
      bins wo={[52:56]};
      bins oor={[64:$]};
    }
    cp_rd_align:coverpoint rd_tr.araddr[1:0]{
      bins aligned={0};
      bins unaligned={[1:3]};
    }

    cx_wr_region_align:cross cp_wr_region,cp_wr_align;
    cx_wr_region_strb:cross cp_wr_region,cp_wstrb;
    cx_rd_region_align:cross cp_rd_region,cp_rd_align;

    cx_rw_region:cross cp_wr_region,cp_rd_region;
    cx_rw_align:cross cp_wr_align,cp_rd_align;
  endgroup

  function new(string name="subscriber",uvm_component parent);
    super.new(name,parent);
    ap_write=new("ap_write",this);
    ap_read=new("ap_read",this);

    wr_tr=new("wr_tr");
    rd_tr=new("rd_tr");
    cg=new();
  endfunction

  virtual function void write_write(transaction t);
    wr_tr=t;
    cg.sample();
  endfunction

  virtual function void write_read(transaction t);
    rd_tr=t;
    cg.sample();
  endfunction

  function void report_phase(uvm_phase phase);
    $display("Total Coverage:%0.2f%%",cg.get_coverage());
  endfunction
endclass
