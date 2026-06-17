"""Built-in trace-analysis project definitions."""


DEFAULT_PROJECTS = [
    {
        "name": "matrix_mul_hls",
        "source": "toy-test-cases/matrix_mul_hls/matrix_mul.cpp",
        "testbench": "toy-test-cases/matrix_mul_hls/matrix_mul_test.cpp",
        "report_bc": (
            "toy-test-cases/matrix_mul_hls/component_matrix_mul/hls/"
            ".autopilot/db/matrix_mul.bc"
        ),
        "interface_xml": (
            "toy-test-cases/matrix_mul_hls/component_matrix_mul/hls/"
            ".autopilot/db/top-io-fe.xml"
        ),
        "include_dirs": ["toy-test-cases/matrix_mul_hls"],
    },
    {
        "name": "vector_mul_shared_bundle_hls",
        "source": "toy-test-cases/vector_mul_shared_bundle_hls/vector_mul.cpp",
        "testbench": "toy-test-cases/vector_mul_shared_bundle_hls/vector_mul_test.cpp",
        "report_bc": (
            "toy-test-cases/vector_mul_shared_bundle_hls/"
            "component_vector_mul_shared_bundle/hls/.autopilot/db/vector_mul.bc"
        ),
        "interface_xml": (
            "toy-test-cases/vector_mul_shared_bundle_hls/"
            "component_vector_mul_shared_bundle/hls/.autopilot/db/top-io-fe.xml"
        ),
        "include_dirs": ["toy-test-cases/vector_mul_shared_bundle_hls"],
    },
    {
        "name": "matrix_mul_row_col_hls",
        "source": "toy-test-cases/matrix_mul_row_col_hls/matmul_row_col.cpp",
        "testbench": (
            "toy-test-cases/matrix_mul_row_col_hls/matmul_row_col_test.cpp"
        ),
        "report_bc": (
            "toy-test-cases/matrix_mul_row_col_hls/component_matmul_row_col/hls/"
            ".autopilot/db/matmul_row_col.bc"
        ),
        "interface_xml": (
            "toy-test-cases/matrix_mul_row_col_hls/component_matmul_row_col/hls/"
            ".autopilot/db/top-io-fe.xml"
        ),
        "include_dirs": ["toy-test-cases/matrix_mul_row_col_hls"],
    },
    {
        "name": "matrix_mul_full_contiguous_hls",
        "source": (
            "toy-test-cases/matrix_mul_full_contiguous_hls/"
            "matmul_full_contiguous.cpp"
        ),
        "testbench": (
            "toy-test-cases/matrix_mul_full_contiguous_hls/"
            "matmul_full_contiguous_test.cpp"
        ),
        "report_bc": (
            "toy-test-cases/matrix_mul_full_contiguous_hls/"
            "component_matmul_full_contiguous/hls/.autopilot/db/"
            "matmul_full_contiguous.bc"
        ),
        "interface_xml": (
            "toy-test-cases/matrix_mul_full_contiguous_hls/"
            "component_matmul_full_contiguous/hls/.autopilot/db/top-io-fe.xml"
        ),
        "include_dirs": ["toy-test-cases/matrix_mul_full_contiguous_hls"],
    },
    {
        "name": "array_partition_block_cyclic",
        "source": (
            "Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/"
            "matmul_partition.cpp"
        ),
        "testbench": (
            "Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/"
            "matmul_partition_test.cpp"
        ),
        "report_bc": (
            "Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/"
            "component_array_partition_block_cyclic/hls/.autopilot/db/"
            "matmul_partition.bc"
        ),
        "interface_xml": (
            "Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/"
            "component_array_partition_block_cyclic/hls/.autopilot/db/top-io-fe.xml"
        ),
        "include_dirs": [
            "Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic"
        ],
    },
    {
        "name": "array_partition_complete",
        "source": (
            "Vitis-HLS-Introductory-Examples/Array/array_partition_complete/"
            "matmul_partition.cpp"
        ),
        "testbench": (
            "Vitis-HLS-Introductory-Examples/Array/array_partition_complete/"
            "matmul_partition_test.cpp"
        ),
        "report_bc": (
            "Vitis-HLS-Introductory-Examples/Array/array_partition_complete/"
            "component_array_partition_complete/hls/.autopilot/db/"
            "matmul_partition.bc"
        ),
        "interface_xml": (
            "Vitis-HLS-Introductory-Examples/Array/array_partition_complete/"
            "component_array_partition_complete/hls/.autopilot/db/top-io-fe.xml"
        ),
        "include_dirs": [
            "Vitis-HLS-Introductory-Examples/Array/array_partition_complete"
        ],
    },
    {
        "name": "burst_rw",
        "source": "Vitis-HLS-Introductory-Examples/Interface/Memory/burst_rw/vadd.cpp",
        "testbench": (
            "Vitis-HLS-Introductory-Examples/Interface/Memory/burst_rw/"
            "vadd_test.cpp"
        ),
        "report_bc": (
            "Vitis-HLS-Introductory-Examples/Interface/Memory/burst_rw/"
            "component_burst_rw/hls/.autopilot/db/vadd.bc"
        ),
        "interface_xml": (
            "Vitis-HLS-Introductory-Examples/Interface/Memory/burst_rw/"
            "component_burst_rw/hls/.autopilot/db/top-io-fe.xml"
        ),
        "include_dirs": [
            "Vitis-HLS-Introductory-Examples/Interface/Memory/burst_rw"
        ],
    },
    {
        "name": "max_widen_port_width",
        "source": (
            "Vitis-HLS-Introductory-Examples/Interface/Memory/"
            "max_widen_port_width/example.cpp"
        ),
        "testbench": (
            "Vitis-HLS-Introductory-Examples/Interface/Memory/"
            "max_widen_port_width/example_test.cpp"
        ),
        "report_bc": (
            "Vitis-HLS-Introductory-Examples/Interface/Memory/"
            "max_widen_port_width/component_max_widen_port_width/hls/"
            ".autopilot/db/example.bc"
        ),
        "interface_xml": (
            "Vitis-HLS-Introductory-Examples/Interface/Memory/"
            "max_widen_port_width/component_max_widen_port_width/hls/"
            ".autopilot/db/top-io-fe.xml"
        ),
        "include_dirs": [
            "Vitis-HLS-Introductory-Examples/Interface/Memory/max_widen_port_width"
        ],
        "link_flags": ["-no-pie"],
    },
]

