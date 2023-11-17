import { CronJob } from "cron";
import schedCtrl from "./sched.ctrl";
const testAlertTask = new CronJob(
	'*/1 * * * *', // cronTime
	function () {
		console.log('You will see this message every minute');
	}, // onTick
	null, // onComplete
	false, // start
	'America/Los_Angeles' // timeZone
);

const cleanImagesTask = new CronJob(
	'0 * * * *',
	schedCtrl.cleanImages,
	null, 
	false,
	'America/Los_Angeles'
)



export default {
	testAlertTask,
	cleanImagesTask
}