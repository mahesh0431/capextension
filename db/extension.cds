// using { SFOData.Candidate } from '../srv/external/RCMCandidate.csn';
using { managed } from '@sap/cds/common';

namespace sf.service.backgroundverification;

entity Candidate{
    key candidateId : String(10);
        virtual  firstName : String(100);
        virtual  contactEmail : String(100);
        virtual  country : String(100);
        to_verfication : Composition of many Verification on to_verfication.to_Applicant = $self
}

// view JobApplicants as select from Candidate mixin {
//     to_verfication : Composition of many Verification on to_verfication.to_Applicant = $self;
// } into {
   
//     key candidateId as Applicant,
//         firstName as Name,
//         contactEmail as Email,
//         country as Country,
//         to_verfication
// };

entity Verification : managed {
    key VerificationUUID : UUID;
    verificationType : String(15);
    status : String(4);
    to_Applicant : Association to Candidate;
}