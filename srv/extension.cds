using {sf.service.backgroundverification as bv} from '../db/extension';

service BackgroundVerification {

    @Capabilities : {
        InsertRestrictions.Insertable : false,
        UpdateRestrictions.Updatable  : true,
        DeleteRestrictions.Deletable  : false
    }
    entity JobApplicants as projection on bv.Candidate;

    @Capabilities : {
        InsertRestrictions.Insertable : true,
        UpdateRestrictions.Updatable  : true,
        DeleteRestrictions.Deletable  : true
    }
    entity Verification  as projection on bv.Verification;
}
