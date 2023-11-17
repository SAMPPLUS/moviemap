import { CronJob } from "cron";

export const testAlert = new CronJob(
	'*/1 * * * *', // cronTime
	function () {
		console.log('You will see this message every minute');
	}, // onTick
	null, // onComplete
	false, // start
	'America/Los_Angeles' // timeZone
);