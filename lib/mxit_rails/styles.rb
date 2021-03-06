module MxitRails
  module Styles

    # Not sure whether a Constant is the neatest/nicest way of storing these?
    StyleList = {}

    def self.get name
      StyleList[name.to_sym]
    end

    def self.add name, content
      content.strip!
      if content[-1] != ';'
        content += ';'
      end
      StyleList[name.to_sym] = content
    end

    # Default styles
    add :left, 'text-align:left;'
    add :center, 'text-align:center;'
    add :right, 'text-align:right;'

  end
end