class App

  def call(env)
    [
      200,
      { 'Content-type' => 'text/plain' },
      ["Welcome!\n"]
     ]
  end  
end
