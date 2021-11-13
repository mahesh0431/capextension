using {BackgroundVerification} from './extension';


// annotate BackgroundVerification.JobApplicants with @odata.draft.enabled;

annotate BackgroundVerification.JobApplicants with @title : 'Applicant' {
    candidateId @title                                      : 'Applicant ID';
    firstName      @title                                      : 'Name';
    contactEmail     @title                                      : 'Email ID';
    country   @title                                      : 'Country';
}

annotate BackgroundVerification.Verification with @title : 'Verification Process' {
    verificationType @title                              : 'Verification Type';
    status           @title                              : 'Status';
}

annotate BackgroundVerification.JobApplicants with @UI : {
    LineItem                  : [
        {Value : candidateId},
        {Value : firstName},
        {Value : contactEmail},
        {Value : country}
    ],
    HeaderInfo                : {
        TypeName       : 'Applicant',
        TypeNamePlural : 'Applicants',
        Title          : {
            $Type : 'UI.DataField',
            Value : candidateId
        },
        Description    : {
            $Type : 'UI.DataField',
            Value : 'firstName'
        }
    },
    Facets                    : [{
        $Type  : 'UI.CollectionFacet',
        ID     : 'ApplVerProcess',
        Facets : [{
            $Type  : 'UI.ReferenceFacet',
            ID     : 'ApplicantData',
            Label  : 'Applicant Information',
            Target : '@UI.FieldGroup#ApplicantData'
        },
        {   
            $Type   : 'UI.ReferenceFacet',
            Target  : 'to_verfication/@UI.LineItem',
            Label   : 'Verfications'
        }]
    }],

    FieldGroup #ApplicantData : {Data : [
        {Value : firstName},
        {Value : contactEmail},
        {Value : country}
    ]},
};

annotate BackgroundVerification.Verification with @UI : {
     LineItem                  : [
        {Value : verificationType},
        {Value : status},
    ],
};