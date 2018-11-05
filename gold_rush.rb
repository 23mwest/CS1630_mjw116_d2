require_relative 'prospect.rb'

# Returns true if and only if:
# 1. There are two and only two arguments
# 2. That argument, when converted to an integer, is nonnegative
# Returns false otherwise
# If any errors occur (e.g. args is nil), just return false - we are
# going to exit anyways, so no need for more detailed categorization
# of the error
def check_args(args)
  begin
    results = [Integer(args[0]), Integer(args[1])] 
  rescue ArgumentError, TypeError
    puts 'Invalid input.'     
  end
  args.count == 2 && results[1] >= 1
rescue StandardError
  false
end

#Execution Starts here 
valid_args = check_args ARGV

#Verify that the arguments are valid 
if valid_args
  p = Prospect.new(ARGV[0].to_i, ARGV[1].to_i)
  p.run(ARGV[1].to_i)
else
# Print the usage message to STDOUT and then exit the program
# Note that it exits with code 1, meaning there was an error
# (0 is generally used to indicate "no error")
  puts 'Usage:\nruby gold_rush.rb *seed* *num_prospectors*\n*seed* should be an integer\n*num_prospectors* should be a nonnegative integer'
  exit 1
end


