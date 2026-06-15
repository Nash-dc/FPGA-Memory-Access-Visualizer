set clock_constraint { \
    name clk \
    module matmul_full_contiguous \
    port ap_clk \
    period 5 \
    uncertainty 1.35 \
}

set all_path {}

set false_path {}

