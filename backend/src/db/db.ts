import postgres, { Sql } from "postgres";
const sql : Sql = postgres(process.env.DB_ADMIN_URL!);
export default sql;