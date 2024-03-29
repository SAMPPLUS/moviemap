import { createServerClient } from "@supabase/ssr";
import { SupabaseClient } from "@supabase/supabase-js";
import { Request, Response } from "express";
import postgres, { Sql } from "postgres";

export const createClient = (context: {req : Request, res : Response}) => {
    return createServerClient(process.env.SUPABASE_URL!, process.env.SUPABASE_KEY!, {
        cookies: {
          get: (key) => {
            const cookies = context.req.cookies
            const cookie = cookies[key] ?? ''
            return decodeURIComponent(cookie)
          },
          set: (key, value, options) => {
            if (!context.res) return
            context.res.cookie(key, encodeURIComponent(value), {
              ...options,
              sameSite: 'Lax',
              httpOnly: true,
            })
          },
          remove: (key, options) => {
            if (!context.res) return
            context.res.cookie(key, '', { ...options, httpOnly: true })
          },
        },
      })
}

export const createSql = (client: SupabaseClient) => {
    const sql = postgres(process.env.DB_HOST!, {
        port: Number(process.env.DB_PORT!),
        database: process.env.DB_NAME!,
        
    })

}