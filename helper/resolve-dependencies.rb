# GO TO THE CORRECT DIRECTORY, NO MATTER WHAT!
Dir::chdir(File::join(Dir::pwd, File::dirname($0), '..'))

require 'yaml'
require './include/ruby/externaltools'

$stdout.sync = true
$stderr.sync = true

deps = ARGV.dup
if deps.include?('--extToolsPath')
    i = deps.index('--extToolsPath')
    ExternalTools::setExtToolsPath(deps[i + 1])
    deps.delete_at(i)
    deps.delete_at(i)
end

deps.each do |dep|
    if dep[0, 5] == 'lang.'
        ExternalTools::install(dep, nil, nil, nil, 'helper/languages/lang.') unless ExternalTools::installed?(dep, 'helper/languages/')
    else
        ExternalTools::install(dep) unless ExternalTools::installed?(dep)
    end
end
