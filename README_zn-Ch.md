这是一个适用于 Windows 10/11 和 Windows Server 的升级助手工具。

由 "[In-Place_Upgrade_Helper]" 项目二次修改编译的中文版本。

此工具可以通过四种不同的方法升级 Windows：

- 通过 `slmgr` 更改产品密钥。此方法仅支持[官方升级路径][1]。

- 启动 `Setup.exe` 并让其自行选择版本。这是普通的就地升级。

- 启动您选择的 Windows 版本的就地升级。此方法通过使用 OEM GLVK 密钥作为安装参数，阻止 Windows 安装程序使用任何固件嵌入密钥或您当前的版本。此方法仅支持[官方升级路径][1]。

- 启动强制就地升级以保留所有应用和设置。此方法在使用 OEM GLVK 密钥之前修改 Windows 注册表，从而启用支持的升级路径之外的版本更改，例如从"专业版"更改为"家庭版"、"教育专业版"或"企业版"，或从"教育版"更改为"IoT 企业版 LTSC"。微软不认可此方法。请自行承担使用此方法的风险。请提前备份您的系统。

将此工具复制到您的安装介质中，与 `setup.exe` 放在一起并运行。或者单独启动它并输入安装文件的路径。
支持外部安装文件，例如已挂载或解压的 ISO。

![IUH3](https://github.com/TheMMC/In-Place_Upgrade_Helper/assets/87301831/d12cf777-2699-4faa-8552-65e818078dd2)
![IUH4](https://github.com/TheMMC/In-Place_Upgrade_Helper/assets/87301831/da2961c9-e1f2-43b1-8141-df625449ff9d)
![IUH1](https://github.com/TheMMC/In-Place_Upgrade_Helper/assets/87301831/65a2bdbb-b052-4941-9ea3-db043227fc2b)
![IUH2](https://github.com/TheMMC/In-Place_Upgrade_Helper/assets/87301831/fc55ea9d-93a2-484d-96cb-c7ccd029af61)

请注意：

- 此工具仍在开发完善中。
- 此工具不会激活 Windows。它使用的任何产品密钥都是占位符 OEM GVLK 密钥。
- 此工具目前已编译成中文。

[1]: https://learn.microsoft.com/zh-cn/windows/deployment/upgrade/windows-edition-upgrades
[In-Place_Upgrade_Helper]: https://github.com/TheMMC/In-Place_Upgrade_Helper/tree/main