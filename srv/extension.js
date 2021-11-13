const cds = require("@sap/cds");

module.exports = cds.service.impl(async (srv) => {
  const SFOData = await cds.connect.to("SFOData");
  const { JobApplicants } = srv.entities;

  srv.on("READ", JobApplicants, async (req, next) => {
    const candidates = await next();
    let candidateIds = [];
    if (Array.isArray(candidates)) {
      candidateIds = candidates.map((item) => item.candidateId);
    } else {
      candidateIds.push(candidates.candidateId);
    }
    if (candidateIds.length > 0) {
      const sfCandidates = await SFOData.run(
        SELECT.from(JobApplicants).where({ candidateId: candidateIds })
      );
      sfCandidates.$count = candidates.$count;
      return sfCandidates;
    }
  });

  //   srv.after("READ", JobApplicants, async (results) => {
  //     let candidateIds = results.map((item) => item.candidateId);
  //     if (candidateIds.length > 0) {
  //       const sfCandidates = await SFOData.run(
  //         SELECT.from(JobApplicants).where({ candidateId: candidateIds })
  //       );
  //       // console.log(results);
  //       // console.log(sfCandidates);
  //       // let mappedItems = sfCandidates.map(function (item) {
  //       //   return { candidateId: item.candidateId, firstName:item.firstName, contactEmail:item.contactEmail };
  //       // });
  //       // console.log(mappedItems);
  //     //   results = sfCandidates;
  //     }
  //   });

  //   srv.on("READ", "Verification", async (req, next) => {
  //     console.log("Verification read");
  //     console.log(req);
  //     delete req.query._validationQuery;
  //     return next();
  //   });

  cds.connect.to("messaging").then((messaging) => {
    messaging.on("capextensionqueue", async (msg) => {
      //   const messagePayload = JSON.stringify(msg.data);
      console.log("===> Received message : " + msg.data.candidateId);
      const candidateId = msg.data.candidateId;
      return cds.run(INSERT.into(JobApplicants).entries({ candidateId }));
    });
  });
});
