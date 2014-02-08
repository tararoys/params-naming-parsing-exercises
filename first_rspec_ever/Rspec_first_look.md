#First Look at Rspec

Oh god, it's a giant wall of text. 

```
Rack Parameter Naming/Parsing
  when specifying basic names for input fields
F    parses input fields into a hash where name is the key, and value is the value (FAILED - 1)


Failures:

  1) Rack Parameter Naming/Parsing when specifying basic names for input fields parses input fields into a hash where name is the key, and value is the value
     Failure/Error: expect(params(form_html)).to eql({"username" => "zerocool", "password" => "1337"})
       
       expected: {"username"=>"zerocool", "password"=>"1337"}
            got: {"??"=>"zerocool", "???"=>"1337"}
       
       (compared using eql?)
       
       Diff:
       @@ -1,3 +1,3 @@
       -"password" => "1337",
       -"username" => "zerocool"
       +"??" => "zerocool",
       +"???" => "1337"
       
     # ./params_parsing_spec.rb:13:in `block (3 levels) in <top (required)>'

Failures:

  1) Rack Parameter Naming/Parsing when specifying basic names for input fields parses input fields into a hash where name is the key, and value is the value
     Failure/Error: expect(params(form_html)).to eql({"username" => "zerocool", "password" => "1337"})
       
       expected: {"username"=>"zerocool", "password"=>"1337"}
            got: {"??"=>"zerocool", "???"=>"1337"}
       
       (compared using eql?)
       
       Diff:
       @@ -1,3 +1,3 @@
       -"password" => "1337",
       -"username" => "zerocool"
       +"??" => "zerocool",
       +"???" => "1337"
       
     # ./params_parsing_spec.rb:13:in `block (3 levels) in <top (required)>'

Finished in 0.00892 seconds
1 example, 1 failure

Failed examples:

rspec ./params_parsing_spec.rb:5 # Rack Parameter Naming/Parsing when specifying basic names for input fields parses input fields into a hash where name is the key, and value is the value

Finished in 0.00892 seconds
1 example, 1 failure

Failed examples:

rspec ./params_parsing_spec.rb:5 # Rack Parameter Naming/Parsing when specifying basic names for input fields parses input fields into a hash where name is the key, and value is the value
```