require_relative "spec_helper"

describe "Rack Parameter Naming/Parsing" do
  context "when specifying _basic names_ for _input fields_" do
    it "parses _input fields_ into a _hash_ where _name_ is the _key_, and _value_ is the _value_" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="text" name="username" value="zerocool" />
        <input type="password" name="password" value="1337" />
      </form>
      HTML

      expect(params(form_html)).to eql({"username" => "zerocool", "password" => "1337"})
    end    
  end

  context "when the expected outcome is a [_parameter_ with an _array of values_](http://stackoverflow.com/questions/1010941/html-input-arrays)" do
    it "_parses_ _multiple input fields_ into an _array of values_ for a _single key_" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="checkbox" name="category_ids[]" value="4" checked />
        <input type="checkbox" name="category_ids[]" value="5" checked />
        <input type="checkbox" name="category_ids[]" value="6" checked />
      </form>
      HTML

      expect(params(form_html)).to eql({"category_ids" => ["4", "5", "6"]})
    end

    it "can be mixed with other _basic field names_ and _array field names_" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="text" name="party_name" value="Karaoke!" />
        <input type="checkbox" name="category_ids[]" value="4" checked />
        <input type="checkbox" name="category_ids[]" value="5" checked />
        <input type="checkbox" name="category_ids[]" value="6" checked />
        <input type="text" name="guest_names[]" value="Joe" />
        <input type="text" name="guest_names[]" value="Jane" />
      </form>
      HTML

      expect(params(form_html)).to eql({
                                        "category_ids" => ["4", "5", "6"],
                                        "party_name" => "Karaoke!",
                                        "guest_names" => ["Joe", "Jane"]
                                        })
    end
  end

  context "when the expected out come is a _parameter_ with a _nested hash value_" do
    it "_parses_ _multiple input fields_ into an _array of values_ for a _single key_" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="text" name="post[title]" value="Eye-catching Title" />
        <textarea name="post[body]">Shallow story...</textarea>
      </form>
      HTML

      expect(params(form_html)).to eql({"post" => {
                                                  "title" => "Eye-catching Title",
                                                  "body" => "Shallow story..."
                                                  }
                                        })
    end
  end

  context "when _nesting parameters_ of _different value types_" do
    it "allows for _nested hashes_ to have _values_ that _parse_ to _arrays of values_" do
      form_html = <<-HTML
      <form action="not_specified" method="post">
        <input type="text" name="post[title]" value="Eye-catching Title" />
        <textarea name="post[body]">Shallow story...</textarea>
        <input type="checkbox" name="post[tag_ids][]" value="87" /> Hard Hitting News
        <input type="checkbox" name="post[tag_ids][]" value="34" /> Breaking
      </form>
      HTML

      expect(params(form_html)).to eql({"post" => {
                                                  "title" => "Eye-catching Title",
                                                  "body" => "Shallow story...",
                                                  "tag_ids" => ["87", "34"]
                                                  }
                                        })
    end

    it "allows for _nested hashes_ to be included in an _array of values_ for a _parameter_" do
        form_html = <<-HTML
        <form action="not_specified" method="post">
          <input type="text" name="guests[][name]" value="Joe" />
          <input type="text" name="guests[][phone]" value="5551212" />
          <input type="text" name="guests[][name]" value="Jane" />
          <input type="text" name="guests[][phone]" value="5551213" />
        </form>
        HTML

        expect(params(form_html)).to eql({"guests" => [
                                                        {"name" => "Joe", "phone" => "5551212"},
                                                        {"name" => "Jane", "phone" => "5551213"}
                                                      ]
                                          })
    end
  end
end