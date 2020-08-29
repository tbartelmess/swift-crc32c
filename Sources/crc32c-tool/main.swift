//
//  File.swift
//  
//
//  Created by Thomas Bartelmess on 2020-08-29.
//

import Foundation
import NIO
import CRC32C

let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)

class CRC32CHandler: ChannelInboundHandler {
    typealias InboundIn = ByteBuffer
    var crc32c = CRC32C()
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        var buffer = unwrapInboundIn(data)
        crc32c.update(buffer.readBytes(length: buffer.readableBytes)!)
    }

    func channelReadComplete(context: ChannelHandlerContext) {
        context.flush()

    }
}
let crcHandler = CRC32CHandler()

func childChannelInitializer(channel: Channel) -> EventLoopFuture<Void> {

    return channel.pipeline.addHandler(crcHandler)
}


let pipeBootstrap = NIOPipeBootstrap(group: eventLoop)
    .channelInitializer(childChannelInitializer(channel:))
    .channelOption(ChannelOptions.maxMessagesPerRead, value: 1)

let channel = try! pipeBootstrap.withPipes(inputDescriptor: STDIN_FILENO, outputDescriptor: STDERR_FILENO).wait()
try channel.closeFuture.wait()

crcHandler.crc32c.finalize()

print("CRC: \(String(format: "%8x", crcHandler.crc32c.value))")
