const sql =require('./db')


const testInsert = async (text) => {
    if(!text){
        return
    }
    const ti = await sql`
    insert into test (
        text
      ) values

      (${ text })
    
      returning 
      id
      `
    return ti[0]
};

module.exports = {testInsert}