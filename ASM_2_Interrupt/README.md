## 作业

> 写一个能实现以下功能的程序
>
> - 运行之后进入以下循环
>   - 10秒禁止键盘响应(即按任何键都没效果)
>   - 10秒密码键盘：简单古典密码，对于按键𝑥𝑥∈𝑎𝑎−𝑧𝑧，显示𝑥𝑥+1𝑚𝑚𝑚𝑚𝑚𝑚26(如键入a，显示b……)

### Thinking & Experience

- 虚拟机的C盘是pce目录里面的`hd0.img`映射进去的
  - 这个文件可以用7-zip解开，但是不能写东西进去
  - Win Image可以读写这个文件
    - 但是注意Win Image不能和pce同时使用这个文件，否则后启动的会运行不起来
- 关于计时
  - 挂1CH的钩子好像比挂08H的钩子好?
  - 1CH中断调用182次差不多是10秒
- 关于屏蔽键盘
  - 用写IMR的方式屏蔽键盘中断，会导致中断屏蔽期间的输入被缓存起来。当开始响应中断的时候，这些输入会一次性显示出来。这是feature
- 关于驻留内存退出
  - 有`INT 21H`和`INT 27H`两种实现，大概的区别下面Reference里面有写
- 用Dos Box比用pce爽多了

### Reference

- Interrupt Jump Table  

  http://www.ctyme.com/intr/int.htm

- Interrupt Services DOS/BIOS/EMS/Mouse

  http://stanislavs.org/helppc/idx_interrupt.html

- Keyboard scancodes

  http://www.win.tue.nl/~aeb/linux/kbd/scancodes-1.html

- 8086汇编小程序

  https://blog.csdn.net/yangbodong22011/article/details/53228028

- awesome-scs

  https://github.com/SJTU-SCS/awesome-scs#computer-organization-and-architecture

- Windows10下搭建汇编语言开发环境（利用DOSBOX和MASM32）

  https://blog.csdn.net/doniexun/article/details/45438457

### 



