require 'rails_helper'

describe ApplicationHelper do

  describe '#categories' do

    it 'should return categories' do
      5.times{ FactoryGirl.create(:category) }
      expect(helper.categories).to eq(Category.all)
    end
  end

  describe '#markdown' do

    it 'should return text with html markup' do
      input = "- List\n # Word \n > qoutes"
      output = "<ul>\n<li>List\n# Word \n&gt; qoutes</li>\n</ul>\n"
      expect(helper.markdown(input)).to eq(output)
    end
  end

  describe '#separated' do

    it 'should return full names separated by \',\'' do
      2.times { FactoryGirl.create(:author) }
      output = "#{Author.first.full_name}, #{Author.second.full_name}"
      expect(helper.separated(Author.all, :full_name)).to eq(output)
    end
  end

  describe '#show_errors' do

    it 'should return fields errors separated by \',\'' do
      obj = Author.new()
      obj.errors.add(:first_name, ['message1', 'message2'])
      expect(helper.show_errors(obj, 'first_name')).to eq('message1, message2')
    end
  end

  describe '#add_error_class' do

    it 'should return error class if there is an error' do
      obj = Author.new()
      obj.errors['first_name'] << 'some error'
      expect(helper.add_error_class(obj, 'first_name')).to eq('has-error')
    end
  end
end
