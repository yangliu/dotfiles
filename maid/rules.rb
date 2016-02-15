#!/usr/bin/ruby
# Need `brew install tag` to manage Finder tags

require 'pathname'

Maid.rules do
	repeat '1d' do
		rule 'Update System' do
			pid = Process.spawn("brewfix;brew update;brew upgrade --all")
			Process.detach pid
			pid = Process.spawn("npm update -g")
			Process.detach pid
			pid = Process.spawn("gem update !psych")
			Process.detach pid
		end
	end

	def is_empty_folder?(path)
		File.directory?(path) && dir("#{path}/*").select { |p| !hidden?(p) }.count == 0
	end

	def is_on_battery?
		if cmd("pmset -g ps | grep AC").length > 0
			return false
		else
			return true
		end
	end

	def dir_downloading(path)
		dir(path).select { |p| !hidden?(p) && downloading?(p) }
	end

	def dir_not_downloading(path)
		dir_safe(path).reject { |path| hidden?(path) }
	end

end
