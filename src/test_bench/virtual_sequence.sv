class virtual_sequence extends uvm_sequence;
  `uvm_object_utils(virtual_sequence)
  `uvm_declare_p_sequencer(virtual_seqr)

  function new(string name="virtual_sequence");
    super.new(name);
  endfunction

  task body();

    tc02_write tc02;
    tc03_aw_first tc03;
    tc04_w_first tc04;
    tc06_wstrb tc06;
    tc07_wr_unaligned tc07;
    tc08_wr_ro tc08;
    tc09_wr_oor tc09;
    tc10_stall_w tc10;
    tc11_stall_aw tc11;
    tc12_stall_bready tc12;
    tc13_b2b_wr_aligned tc13;
    tc14_b2b_wr_unaligned tc14;
    tc15_read tc15;
    tc16_read_rand_strb tc16;
    tc17_rd_unaligned tc17;
    tc18_rd_wo tc18;
    tc19_rd_oor tc19;
    tc20_stall_rready tc20;
    tc21_b2b_rd_aligned tc21;
    tc22_b2b_rd_unaligned tc22;
    tc23_b2b_rd_wo tc23;
    tc24_wr_rd_same_aligned tc24;
    tc25_wr_rd_same_unaligned tc25;
    tc26_par_rd_wr tc26;
    tc27_wr_ro_rd_ro tc27;
    tc28_wr_wo_rd_wo tc28;
    tc29_wr_rd_unaligned tc29;
    tc30_wr_unaligned_rd_aligned tc30;
    tc31_rd_unaligned_wr_aligned tc31;
    tc32_wr_rd_oor tc32;
    tc33_par_bready_stall tc33;
    tc34_par_rready_stall tc34;
    tc35_write_at_unaligned tc35;
    tc36_order_closure tc36;
    tc37_wr_ro_unaligned tc37;
    tc38_rw_region_gap_closure tc38;

    `uvm_info(get_type_name(),"Starting virtual sequence",UVM_LOW)

    // tc01=tc01_reset::type_id::create("tc01");
    // tc01.start(p_sequencer.wr_seqr);
    // (Note: Left tc01 commented out because it is not declared in your variables block above)

    tc02=tc02_write::type_id::create("tc02");
    tc02.start(p_sequencer.wr_seqr);

    tc03=tc03_aw_first::type_id::create("tc03"); 
    tc03.start(p_sequencer.wr_seqr);

    tc04=tc04_w_first::type_id::create("tc04"); 
    tc04.start(p_sequencer.wr_seqr);

    tc06=tc06_wstrb::type_id::create("tc06"); 
    tc06.start(p_sequencer.wr_seqr);

    tc07=tc07_wr_unaligned::type_id::create("tc07"); 
    tc07.start(p_sequencer.wr_seqr);

    tc08=tc08_wr_ro::type_id::create("tc08"); 
    tc08.start(p_sequencer.wr_seqr);

    tc09=tc09_wr_oor::type_id::create("tc09"); 
    tc09.start(p_sequencer.wr_seqr);

    tc10=tc10_stall_w::type_id::create("tc10"); 
    tc10.start(p_sequencer.wr_seqr);

    tc11=tc11_stall_aw::type_id::create("tc11"); 
    tc11.start(p_sequencer.wr_seqr);

    tc12=tc12_stall_bready::type_id::create("tc12"); 
    tc12.start(p_sequencer.wr_seqr);

    tc13=tc13_b2b_wr_aligned::type_id::create("tc13"); 
    tc13.start(p_sequencer.wr_seqr);

    tc14=tc14_b2b_wr_unaligned::type_id::create("tc14"); 
    tc14.start(p_sequencer.wr_seqr);


    tc16=tc16_read_rand_strb::type_id::create("tc16"); 
    tc16.start(p_sequencer.rd_seqr);

    tc17=tc17_rd_unaligned::type_id::create("tc17"); 
    tc17.start(p_sequencer.rd_seqr);

    tc18=tc18_rd_wo::type_id::create("tc18"); 
    tc18.start(p_sequencer.rd_seqr);

    tc19=tc19_rd_oor::type_id::create("tc19"); 
    tc19.start(p_sequencer.rd_seqr);

    tc20=tc20_stall_rready::type_id::create("tc20"); 
    tc20.start(p_sequencer.rd_seqr);

    tc21=tc21_b2b_rd_aligned::type_id::create("tc21"); 
    tc21.start(p_sequencer.rd_seqr);

    tc22=tc22_b2b_rd_unaligned::type_id::create("tc22"); 
    tc22.start(p_sequencer.rd_seqr);

    tc23=tc23_b2b_rd_wo::type_id::create("tc23"); 
    tc23.start(p_sequencer.rd_seqr);

    tc24=tc24_wr_rd_same_aligned::type_id::create("tc24");
    tc24.wr_sqr=p_sequencer.wr_seqr; 
    tc24.rd_sqr=p_sequencer.rd_seqr;
    tc24.start(null);

    tc25=tc25_wr_rd_same_unaligned::type_id::create("tc25");
    tc25.wr_sqr=p_sequencer.wr_seqr;
    tc25.rd_sqr=p_sequencer.rd_seqr;
    tc25.start(null);

    tc26=tc26_par_rd_wr::type_id::create("tc26");
    tc26.wr_sqr=p_sequencer.wr_seqr; 
    tc26.rd_sqr=p_sequencer.rd_seqr;
    tc26.start(null);

    tc27=tc27_wr_ro_rd_ro::type_id::create("tc27");
    tc27.wr_sqr=p_sequencer.wr_seqr;
    tc27.rd_sqr=p_sequencer.rd_seqr; 
    tc27.start(null);

    tc28=tc28_wr_wo_rd_wo::type_id::create("tc28");
    tc28.wr_sqr=p_sequencer.wr_seqr; 
    tc28.rd_sqr=p_sequencer.rd_seqr; 
    tc28.start(null);

    tc29=tc29_wr_rd_unaligned::type_id::create("tc29");
    tc29.wr_sqr=p_sequencer.wr_seqr; 
    tc29.rd_sqr=p_sequencer.rd_seqr; 
    tc29.start(null);

    tc30=tc30_wr_unaligned_rd_aligned::type_id::create("tc30");
    tc30.wr_sqr=p_sequencer.wr_seqr; 
    tc30.rd_sqr=p_sequencer.rd_seqr; 
    tc30.start(null);

    tc31=tc31_rd_unaligned_wr_aligned::type_id::create("tc31");
    tc31.wr_sqr=p_sequencer.wr_seqr; 
    tc31.rd_sqr=p_sequencer.rd_seqr; 
    tc31.start(null);

    tc32=tc32_wr_rd_oor::type_id::create("tc32");
    tc32.wr_sqr=p_sequencer.wr_seqr; 
    tc32.rd_sqr=p_sequencer.rd_seqr; 
    tc32.start(null);

    tc33=tc33_par_bready_stall::type_id::create("tc33");
    tc33.wr_sqr=p_sequencer.wr_seqr; 
    tc33.rd_sqr=p_sequencer.rd_seqr;
    tc33.start(null);

    tc34=tc34_par_rready_stall::type_id::create("tc34");
    tc34.wr_sqr=p_sequencer.wr_seqr;
    tc34.rd_sqr=p_sequencer.rd_seqr;
    tc34.start(null);

    tc35=tc35_write_at_unaligned::type_id::create("tc35");
    tc35.start(p_sequencer.wr_seqr);

    
    tc15=tc15_read::type_id::create("tc15"); 
    tc15.start(p_sequencer.rd_seqr);
    
      tc36=tc36_order_closure::type_id::create("tc36"); tc36.start(p_sequencer.wr_seqr);
    tc37=tc37_wr_ro_unaligned::type_id::create("tc37"); tc37.start(p_sequencer.wr_seqr);
 
    tc38=tc38_rw_region_gap_closure::type_id::create("tc38");
    tc38.wr_sqr=p_sequencer.wr_seqr; tc38.rd_sqr=p_sequencer.rd_seqr; tc38.start(null);

    `uvm_info(get_type_name(),"Virtual sequence completed",UVM_LOW)
  endtask
endclass
