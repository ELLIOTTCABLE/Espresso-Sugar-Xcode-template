# encoding: UTF-8

Projects = [
  'Espresso Sugar'
]

FilesToMacroExpand = {
  'EspressoSugar_Prefix.pch' => 'MacRoman',
  File.join('EspressoSugar.xcodeproj', 'project.pbxproj') => 'UTF-8'
}

def replace_in_file find, replace, file, encoding
  File.open(File.expand_path(file), 'r', encoding: "#{encoding}:UTF-8") {|f| @contents = f.read }
  @contents.gsub! find, replace
  File.open(File.expand_path(file), 'w', encoding: "#{encoding}:UTF-8") {|f| f.write @contents }
end

desc "Modifies the project templates' files so you can edit them in Xcode"
task :projectize do
  Projects.each do |project|
    FilesToMacroExpand.each do |file, encoding|
      replace_in_file "«PROJECTNAME»", "EspressoSugar",
        File.join(File.dirname(__FILE__), project, file), encoding
    end
  end
end

desc "Modifies the project templates' files so you can commit them"
task :templatize do
  Projects.each do |project|
    FilesToMacroExpand.each do |file, encoding|
      replace_in_file "EspressoSugar", "«PROJECTNAME»",
        File.join(File.dirname(__FILE__), project, file), encoding
    end
  end
end
