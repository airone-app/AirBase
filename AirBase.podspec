#
# Be sure to run `pod lib lint AirRequest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  # pod基本描述信息
  s.name               = "AirBase"                                  # Pod的名称
  s.version            = "1.0.0"                                             # Pod版本号
  s.summary            = "The base lib of Airone"     # pod的简短介绍，下面是详细介绍
  s.description        = <<-DESC
                        Contain the base lib of AirOne.
                        DESC
  s.homepage           = "https://www.jyblife.com"        # 项目主页,这里要填写可以访问到的地址，不然验证不通过
  # s.screenshots        = "www.example.com/screenshots_1", "www.example.com/screenshots_2"    # 截图
  s.license            = 'MIT'               # 开源协议
  s.author             = { "luochenxun" => "luochenxun@gmail.com" }            # 作者信息
  s.source             = { :git => "http://git.jtjr.com/chauncey/AirBase.git", :tag => "#{s.version}" }   # 项目地址
  # source有submodules需要增加声明 :submodules => true
  # s.social_media_url = 'https://xx.mp4'                # 多媒体介绍地址

  # pod基本编译信息
  s.platform     = :ios, '9.0'            #支持的平台及版本
  s.requires_arc = true                   #是否使用ARC，如果指定具体文件，则具体的问题使用ARC

  # 源码及资源信息
  s.source_files = 'ios/Classes/**/*'     #代码源文件地址，**/*表示Classes目录及其子目录下所有文件，如果有多个目录下则用逗号分开，如果需要在项目中分组显示，这里也要做相应的设置
  # s.exclude_files = "Classes/Exclude"   #不包含的文件
  # s.resource_bundles = {
  #   'assert' => ['Pod/ios/Assets/*.png']
  # }                                       #资源文件地址(打进独立的Bundle)
  # s.resources = 'Pod/Assets/*.png'        #打进app的main bundle中
  # s.public_header_files = 'Pod/ios/Classes/**/*.h'   #公开头文件地址

  # 子模块
  # 子模块使得使用者可以依据自己需要选择自己感兴趣的子库，而不会引入自己不感兴趣的模块，只需要使用
  # pod 'MyPod/MySub'
  # s.subspec 'MySub' do |mysub|
  #     mysub.requires_arc = true
  #     mysub.source_files = 'AppBase/Classes/mysub/**/*.{h.m}'
  #     mysub.compiler_flags = '-Wno-incomplete-implementation -Wno-missing-prototypes'
  #     mysub.dependency 'Facebook-iOS-SDK'
  # end

  # 依赖库
  # s.frameworks = 'UIKit'                # 所需的framework，多个用逗号隔开

  # s.dependency 'AirRequest', '~> 1.0'     # 本地依赖库
  # s.dependency 'AFNetworking', '~> 3.0'   # 依赖关系，该项目所依赖的其他库，如果有多个需要填写多个s.dependency
end
