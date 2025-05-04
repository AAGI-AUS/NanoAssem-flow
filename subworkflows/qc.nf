//
// QC module here
//

// Call module
include { NANOQ_QC_MOD } from '../modules/local/software/nanoq/main_qc.nf'

workflow QC {

    take:
    reads

    main:
    NANOQ_QC_MOD(reads)

    emit:
    qc_reports = NANOQ_QC_MOD.out.nanoqreport
}
