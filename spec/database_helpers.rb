require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  result = connection.query("SELECT * FROM bookmarks WHERE id = #{id};")
  result.first #result will only yield one result, but we need to call first because result is an enumerator with a hash(or multiple if there were duplicate ids) inside it. we need to call .first to instruct it to look at this hash. can think of it like this: result = [ { 'id': 1, 'peep': 'this is a peep', 'username': 'me' } ] (although it's not technically an array)
end 

