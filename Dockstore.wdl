version 1.0
task viewRegion {
    input {
        File drs_uri_bam
        File drs_uri_bai
        String region
        Int mem_gb
        Int addtional_disk_size = 100 
        Int machine_mem_size = 15
        Int disk_size 
 

    }

	command {
		#bash -c "echo samtools; samtools view ~{drs_uri_bam} -X ~{drs_uri_bai} chrM -b -o ~{drs_uri_bam}_chrM.extracted.bam"
		bash -c "echo ~{drs_uri_bam}"
		bash -c "out_put_name= ~{drs_uri_bam}_chrm.bam"
		bash -c "echo ~{out_put_name}"
		
	}

	output {
		String extractedBam_name="~{out_put_name}"
	}

	runtime {
		docker: "quay.io/ldcabansay/samtools:latest"
		memory: mem_gb + "GB"
		disks: "local-disk " + disk_size + " HDD"
	}

	meta {
		author: "jlanej"
	}
}

workflow extractRegionWorkflow {
    input {
        File drs_uri_bam
		File drs_uri_bai
        String region
        Int mem_gb
    }
	call viewRegion { 
		input:
	 drs_uri_bam=drs_uri_bam,
	 drs_uri_bai=drs_uri_bai,
	 region=region,
	 mem_gb=mem_gb 
	}
	#output {
		#File output_bam=viewRegion.extractedBam
		#}
}

#		
