class my_subscriber extends uvm_subscriber #(my_transaction);
    `uvm_component_utils(my_subscriber)

    bit rd_en, wr_en, full, empty;

    covergroup cover_bus;
        cp_rd_en: coverpoint rd_en;
        cp_wr_en: coverpoint wr_en;
        cp_full:  coverpoint full;
        cp_empty: coverpoint empty;
        cx_all: cross cp_rd_en, cp_wr_en, cp_full, cp_empty {
            illegal_bins rd_lead_to_full  = binsof(cp_rd_en) intersect {1}
                                         && binsof(cp_full)  intersect {1};
            illegal_bins wr_lead_to_empty = binsof(cp_wr_en) intersect {1}
                                         && binsof(cp_empty) intersect {1};
            illegal_bins full_and_empty   = binsof(cp_full)  intersect {1}
                                         && binsof(cp_empty) intersect {1};
        }
    endgroup

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
        cover_bus = new();
    endfunction

    function void write(my_transaction t);
        rd_en = t.rd_en;
        wr_en = t.wr_en;
        full = t.full;
        empty = t.empty;
        cover_bus.sample();
    endfunction
endclass