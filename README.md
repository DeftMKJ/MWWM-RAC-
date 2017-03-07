## MVVM + RAC完整示例Demo
![](https://github.com/DeftMKJ/MWWM-RAC-/blob/master/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-03-07%2015.59.04.png)
  1.用到了网络请求的信号传递<br/>
  2.用RACObserve宏进行属性的KVO观察<br/>
  3.用RACSubject进行数据的回调<br/>
  4.用RACSequence进行异步数组和字典(打印的是RACTuple)的遍历<br/>
  5.RAC-->combineLatest的方法进行简单多输入框登录注册页面模拟<br/>
![Demo](https://github.com/DeftMKJ/MWWM-RAC-/blob/master/1.gif);

<br/><br/>

## RAC的流程介绍--->RACSingnal
网上很多基本的介绍，这里主要讲一下流程
1.如果用`RACSignal`来创建信号（内部Block有发送信号以及取消信号的回调，为什么是3和4呢，原因在后面）
```objc
// 1.创建信号
RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
// 3.发送信号
[subscriber sendNext:@"mkj"];
[subscriber sendCompleted];
// 4.取消信号，如果信号想要被取消，就必须返回一个RACDisposable
// 当信号被手动或者自动取消订阅之后会回调到这里，进行一些资源的释放
return [RACDisposable disposableWithBlock:^{
NSLog(@"取消订阅");
}];
}];
```

注意：上面创建的方法内部代码主要归结于创建一个集成于`RACSignal`的子类--->`RACDynamicSignal`，然后
通过静态方法实例化出来，并把传进去的任务Block进行对象属性的存储
```objc
+ (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe {
	RACDynamicSignal *signal = [[self alloc] init];
	signal->_didSubscribe = [didSubscribe copy];
	return [signal setNameWithFormat:@"+createSignal:"];
}
```
2.创建的信号RACSignal(子类RACDynamicSignal)来调用第二步`[Signale subscribeNext：^{}];`来进行信号的订阅,内部转换代码
```objc
RACSubscriber *o = [RACSubscriber subscriberWithNext:nextBlock error:NULL completed:NULL];
	return [self subscribe:o];
```

注意：这里RAC的设计者向我们隐藏了RACSubscriber，对外暴露了RACSignal，所有的内部工作都由RACSubsriber进行完成传递
如果你再点进去，这里传递的Signal，会判断之前创建的时候传进的Block是否为空，如果有任务，直接回调Block
```objc
RACDisposable *innerDisposable = self.didSubscribe(subscriber);


3.现在有人订阅了，又回调了Block，然后触发任务，完成之后调用
```objc
[subscriber sendNext:@"mkj"];
[subscriber sendCompleted];

// 内部代码最终调用方法如下
- (void)sendNext:(id)value {
	@synchronized (self) {
		void (^nextBlock)(id) = [self.next copy];
		if (nextBlock == nil) return;

		nextBlock(value);
	}
}
最终回调到订阅的时候NextBlock的任务
```

4.这个可有可无，返回一个RACDisposable，对订阅取消进行资源的释放


总结：把他比喻成工厂，当你需要打开生产流水线的时候（创建信号，带有任务），这个时候你工人都没有，根本不会走你的任务
信号不会被传递，而你有工人来的时候（就是订阅了信号），这个时候流水线才开始进行加工，这就是个人理解的冷信号模式
也可以把冷信号理解为未被订阅的信号，理解为信号里面的任务是不会进行的，只有订阅者的加入，信号才会变成热信号
也就是这玩意需要手动开启信号


## RAC的流程介绍--->RACSubject(继承与RACSignal)
1.创建信号
```objc
RACSubject *subject = [RACSubject subject];
该方法和上面的创建方式有所不同，他的实例化出来之后只是创建了一个数组，专门用来存储订阅信号的订阅者
```

2.订阅信号
```objc
[subject subscribeNext:^(id x) {
// 当信号sendNext的时候会回调
NSLog(@"%@",x);
}];
// 这方法也是和上面的有所区别，RACSubject该对象会把订阅者放到之前创建的数组里面，然后啥都不做了
```

3.[subject sendNext:value];
```objc
内部代码
[self enumerateSubscribersUsingBlock:^(id<RACSubscriber> subscriber) {
		[subscriber sendNext:value];
	}];
可以看出，当他调用sendNext的时候，是会进行数组的遍历，然后挨个对订阅者发送消息
```

总结：其实这就是所谓的热信号模式，还是拿工厂来做比喻，`RACSubject`是不管你有没有人订阅，我工厂24小时开启流水线
我管你有没有人加工，有人来了，我就用数组登记一下，信号来了的时候你们就负责接收任务，没人的时候我还是就好比我的员工
花名册是空的，但是照样生产，只是没人做事罢了，那么这里的RAC信号流就是没人处理罢了，会被丢弃


知识点：区别RACSubject和RACSignal<br/>
1.我个人理解，前者是冷信号模式，需要有人订阅才开启热信号，后者是热信号默认，不管你有没有订阅<br/>
2.前者其实是一旦有人订阅，就会去做对应的一组信号任务，然后进行回调，可以理解为有人的时候任务启动，没人的时候挂机
没错，我是把它简单理解为代理，后者是热信号，信号负责收集订阅者数组，发信号的时候回遍历订阅者，一个个执行任务
你可以把它理解为通知，我管你有没有接收，我照样发送，没人就丢弃<br/>
3.前者个人用来进行网络请求，后者进行类似代理或者通知的数据传递模式，这样就可以简单的理解为，RAC其实就是把apple的一套
delegate，Notification，KVO等一系列方法综合起来了，用起来更舒服罢了<br/>
4.那么MVVM模式下，本身就多了个ViewModel，交互起来需要更多的设计模式协助，RAC就解决了这个问题，直接用这个设计模式来搞
数据传递和监听的代码就清晰很多了<br/>
