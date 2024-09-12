const { execSync } = require("child_process");
const path = require("path");
const { writeToPath } = require('@fast-csv/format');


// Volunteer Events
let volunteerEventResult = execSync(
  'sf data query -q "SELECT Id from mvpbo3__Volunteer_Event__c" --json',
  { encoding: "utf8" }
);
let parsedvolunteerEventResult = JSON.parse(
  volunteerEventResult
).result.records;
console.log(
  `> ${parsedvolunteerEventResult.length} Volunteer Event records fetched`
);
const volunteerRows = [];
parsedvolunteerEventResult.forEach((event) => {
  volunteerRows.push({
    Id: event.Id,
  })
})

writeToPath(
  path.resolve(__dirname, "../../data/volunteerRecordsToDelete.csv"),
  volunteerRows,
  { headers: true }
)
  .on("error", (err) => console.error(err))
  .on("finish", () => {
    execSync(
      "sf data delete bulk -f data/volunteerRecordsToDelete.csv -w 5 -s mvpbo3__Volunteer_Event__c",
      { encoding: "utf8" }
    );
    console.log("Done deleting Volunteer Events.");
  });

// CONTACT

let contactResult = execSync(
  'sf data query -q "SELECT Id from Contact" --json',
  { encoding: "utf8" }
);
let parsedContactResult = JSON.parse(contactResult).result.records;
console.log(`> ${parsedContactResult.length} Contact records fetched`);

const contactRows = [];
parsedContactResult.forEach((contact) => {
  contactRows.push({ Id: contact.Id });
});
writeToPath(
  path.resolve(__dirname, "../../data/contactRecordsToDelete.csv"),
  contactRows,
  { headers: true }
)
  .on("error", (err) => console.error(err))
  .on("finish", () => {
    execSync(
      "sf data delete bulk -f data/contactRecordsToDelete.csv -w 5 -s Contact",
      { encoding: "utf8" }
    );
    console.log("Done deleting Contacts");
  });

