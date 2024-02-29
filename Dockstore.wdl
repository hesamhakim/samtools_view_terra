version 1.0
task ExtractBam {
    input {
		File drs_uri_bam
		File drs_uri_bam_bai
		File bam_file_name
		String output_path
		File bed
		Int mem_gb
		Int addtional_disk_size = 200 
		Int machine_mem_size = 15
		Int disk_size = ceil(size(drs_uri_bam, "GB")) + addtional_disk_size
		}

	command <<<
		bash -c "echo ~{bam_file_name}; samtools; samtools view ~{drs_uri_bam} -X ~{drs_uri_bam_bai} chrM -b -o chrM.extracted.bam"
		>>>

	output {
		File extractedBam = "chrM.extracted.bam"

	}

	runtime {
		docker: "quay.io/ldcabansay/samtools:latest"
		memory: mem_gb + "GB"
		disks: "local-disk " + disk_size + " HDD"
	}

	meta {
		author: "hesam"
	}
}

workflow extractRegionWorkflow {
	input {
	File drs_uri_bam
	File drs_uri_bam_bai
	File bam_file_name
	File bed
	String output_path
	Int mem_gb
	}
	call ExtractBam { 
		input:
	 drs_uri_bam=drs_uri_bam,
	 drs_uri_bam_bai=drs_uri_bam_bai,
	 bam_file_name=bam_file_name,
	 bed=bed,
	 output_path=output_path,
	 mem_gb=mem_gb 
	}
}

#