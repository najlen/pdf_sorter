class RuleSet
  attr_accessor :rules, :base_dir

  def initialize(base_dir)
    @base_dir = base_dir
    @rules = []
  end

end