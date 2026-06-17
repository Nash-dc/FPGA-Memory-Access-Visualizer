; ModuleID = 'third_party/Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/matmul_partition.cpp'
source_filename = "third_party/Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/matmul_partition.cpp"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: nounwind
define void @_Z16matmul_partitionPiS_S_ii(i32* %in1, i32* %in2, i32* %out_r, i32 %dim, i32 %rep_count) #0 !dbg !6 {
entry:
  %in1.addr = alloca i32*, align 8
  %in2.addr = alloca i32*, align 8
  %out_r.addr = alloca i32*, align 8
  %dim.addr = alloca i32, align 4
  %rep_count.addr = alloca i32, align 4
  %A = alloca [256 x i32], align 4
  %B = alloca [256 x i32], align 4
  %C = alloca [256 x i32], align 4
  %itr = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %itr7 = alloca i32, align 4
  %i8 = alloca i32, align 4
  %j9 = alloca i32, align 4
  %x = alloca i32, align 4
  %cleanup.dest.slot = alloca i32, align 4
  %i33 = alloca i32, align 4
  %j38 = alloca i32, align 4
  %result = alloca i32, align 4
  %k = alloca i32, align 4
  %itr73 = alloca i32, align 4
  %i74 = alloca i32, align 4
  %j75 = alloca i32, align 4
  store i32* %in1, i32** %in1.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %in1.addr, metadata !11, metadata !DIExpression()), !dbg !12
  store i32* %in2, i32** %in2.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %in2.addr, metadata !13, metadata !DIExpression()), !dbg !14
  store i32* %out_r, i32** %out_r.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %out_r.addr, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 %dim, i32* %dim.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %dim.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 %rep_count, i32* %rep_count.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %rep_count.addr, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.sideeffect() #4 [ "xlx_m_axi"(i32* %in1, [0 x i8] zeroinitializer, i64 256, [0 x i8] zeroinitializer, [0 x i8] zeroinitializer, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, [0 x i8] zeroinitializer) ], !dbg !21
  call void @llvm.sideeffect() #4 [ "xlx_m_axi"(i32* %in2, [0 x i8] zeroinitializer, i64 256, [0 x i8] zeroinitializer, [0 x i8] zeroinitializer, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, [0 x i8] zeroinitializer) ], !dbg !22
  call void @llvm.sideeffect() #4 [ "xlx_m_axi"(i32* %out_r, [0 x i8] zeroinitializer, i64 256, [0 x i8] zeroinitializer, [0 x i8] zeroinitializer, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, [0 x i8] zeroinitializer) ], !dbg !23
  %0 = bitcast [256 x i32]* %A to i8*, !dbg !24
  call void @llvm.lifetime.start.p0i8(i64 1024, i8* %0) #5, !dbg !24
  call void @llvm.dbg.declare(metadata [256 x i32]* %A, metadata !25, metadata !DIExpression()), !dbg !29
  %1 = bitcast [256 x i32]* %B to i8*, !dbg !30
  call void @llvm.lifetime.start.p0i8(i64 1024, i8* %1) #5, !dbg !30
  call void @llvm.dbg.declare(metadata [256 x i32]* %B, metadata !31, metadata !DIExpression()), !dbg !32
  %2 = bitcast [256 x i32]* %C to i8*, !dbg !33
  call void @llvm.lifetime.start.p0i8(i64 1024, i8* %2) #5, !dbg !33
  call void @llvm.dbg.declare(metadata [256 x i32]* %C, metadata !34, metadata !DIExpression()), !dbg !35
  call void @llvm.sideeffect() #6 [ "xlx_array_partition"([256 x i32]* %A, i32 0, i32 16, i32 1, i1 false) ], !dbg !36
  call void @llvm.sideeffect() #6 [ "xlx_array_partition"([256 x i32]* %B, i32 1, i32 16, i32 1, i1 false) ], !dbg !37
  br label %readA, !dbg !37

readA:                                            ; preds = %entry
  %3 = bitcast i32* %itr to i8*, !dbg !38
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %3) #5, !dbg !38
  call void @llvm.dbg.declare(metadata i32* %itr, metadata !40, metadata !DIExpression()), !dbg !41
  store i32 0, i32* %itr, align 4, !dbg !41
  %4 = bitcast i32* %i to i8*, !dbg !38
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %4) #5, !dbg !38
  call void @llvm.dbg.declare(metadata i32* %i, metadata !42, metadata !DIExpression()), !dbg !43
  store i32 0, i32* %i, align 4, !dbg !43
  %5 = bitcast i32* %j to i8*, !dbg !38
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %5) #5, !dbg !38
  call void @llvm.dbg.declare(metadata i32* %j, metadata !44, metadata !DIExpression()), !dbg !45
  store i32 0, i32* %j, align 4, !dbg !45
  br label %for.cond, !dbg !38

for.cond:                                         ; preds = %for.inc, %readA
  %6 = load i32, i32* %itr, align 4, !dbg !46
  %7 = load i32, i32* %dim.addr, align 4, !dbg !48
  %8 = load i32, i32* %dim.addr, align 4, !dbg !49
  %mul = mul nsw i32 %7, %8, !dbg !50
  %cmp = icmp slt i32 %6, %mul, !dbg !51
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !dbg !52

for.cond.cleanup:                                 ; preds = %for.cond
  %9 = bitcast i32* %j to i8*, !dbg !53
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %9) #5, !dbg !53
  %10 = bitcast i32* %i to i8*, !dbg !53
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %10) #5, !dbg !53
  %11 = bitcast i32* %itr to i8*, !dbg !53
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %11) #5, !dbg !53
  br label %for.end

for.body:                                         ; preds = %for.cond
  %12 = load i32, i32* %j, align 4, !dbg !54
  %13 = load i32, i32* %dim.addr, align 4, !dbg !57
  %cmp1 = icmp eq i32 %12, %13, !dbg !58
  br i1 %cmp1, label %if.then, label %if.end, !dbg !59

if.then:                                          ; preds = %for.body
  store i32 0, i32* %j, align 4, !dbg !60
  %14 = load i32, i32* %i, align 4, !dbg !62
  %inc = add nsw i32 %14, 1, !dbg !62
  store i32 %inc, i32* %i, align 4, !dbg !62
  br label %if.end, !dbg !63

if.end:                                           ; preds = %if.then, %for.body
  %15 = load i32*, i32** %in1.addr, align 8, !dbg !64
  %16 = load i32, i32* %itr, align 4, !dbg !65
  %idxprom = sext i32 %16 to i64, !dbg !64
  %arrayidx = getelementptr inbounds i32, i32* %15, i64 %idxprom, !dbg !64
  %17 = load i32, i32* %arrayidx, align 4, !dbg !64
  %18 = load i32, i32* %i, align 4, !dbg !66
  %mul2 = mul nsw i32 %18, 16, !dbg !67
  %19 = load i32, i32* %j, align 4, !dbg !68
  %add = add nsw i32 %mul2, %19, !dbg !69
  %idxprom3 = sext i32 %add to i64, !dbg !70
  %arrayidx4 = getelementptr inbounds [256 x i32], [256 x i32]* %A, i64 0, i64 %idxprom3, !dbg !70
  store i32 %17, i32* %arrayidx4, align 4, !dbg !71
  br label %for.inc, !dbg !72

for.inc:                                          ; preds = %if.end
  %20 = load i32, i32* %itr, align 4, !dbg !73
  %inc5 = add nsw i32 %20, 1, !dbg !73
  store i32 %inc5, i32* %itr, align 4, !dbg !73
  %21 = load i32, i32* %j, align 4, !dbg !74
  %inc6 = add nsw i32 %21, 1, !dbg !74
  store i32 %inc6, i32* %j, align 4, !dbg !74
  br label %for.cond, !dbg !53, !llvm.loop !75

for.end:                                          ; preds = %for.cond.cleanup
  br label %readB, !dbg !76

readB:                                            ; preds = %for.end
  %22 = bitcast i32* %itr7 to i8*, !dbg !80
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %22) #5, !dbg !80
  call void @llvm.dbg.declare(metadata i32* %itr7, metadata !82, metadata !DIExpression()), !dbg !83
  store i32 0, i32* %itr7, align 4, !dbg !83
  %23 = bitcast i32* %i8 to i8*, !dbg !80
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %23) #5, !dbg !80
  call void @llvm.dbg.declare(metadata i32* %i8, metadata !84, metadata !DIExpression()), !dbg !85
  store i32 0, i32* %i8, align 4, !dbg !85
  %24 = bitcast i32* %j9 to i8*, !dbg !80
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %24) #5, !dbg !80
  call void @llvm.dbg.declare(metadata i32* %j9, metadata !86, metadata !DIExpression()), !dbg !87
  store i32 0, i32* %j9, align 4, !dbg !87
  br label %for.cond10, !dbg !80

for.cond10:                                       ; preds = %for.inc25, %readB
  %25 = load i32, i32* %itr7, align 4, !dbg !88
  %26 = load i32, i32* %dim.addr, align 4, !dbg !90
  %27 = load i32, i32* %dim.addr, align 4, !dbg !91
  %mul11 = mul nsw i32 %26, %27, !dbg !92
  %cmp12 = icmp slt i32 %25, %mul11, !dbg !93
  br i1 %cmp12, label %for.body14, label %for.cond.cleanup13, !dbg !94

for.cond.cleanup13:                               ; preds = %for.cond10
  %28 = bitcast i32* %j9 to i8*, !dbg !95
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %28) #5, !dbg !95
  %29 = bitcast i32* %i8 to i8*, !dbg !95
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %29) #5, !dbg !95
  %30 = bitcast i32* %itr7 to i8*, !dbg !95
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %30) #5, !dbg !95
  br label %for.end28

for.body14:                                       ; preds = %for.cond10
  %31 = load i32, i32* %j9, align 4, !dbg !96
  %32 = load i32, i32* %dim.addr, align 4, !dbg !99
  %cmp15 = icmp eq i32 %31, %32, !dbg !100
  br i1 %cmp15, label %if.then16, label %if.end18, !dbg !101

if.then16:                                        ; preds = %for.body14
  store i32 0, i32* %j9, align 4, !dbg !102
  %33 = load i32, i32* %i8, align 4, !dbg !104
  %inc17 = add nsw i32 %33, 1, !dbg !104
  store i32 %inc17, i32* %i8, align 4, !dbg !104
  br label %if.end18, !dbg !105

if.end18:                                         ; preds = %if.then16, %for.body14
  %34 = load i32*, i32** %in2.addr, align 8, !dbg !106
  %35 = load i32, i32* %itr7, align 4, !dbg !107
  %idxprom19 = sext i32 %35 to i64, !dbg !106
  %arrayidx20 = getelementptr inbounds i32, i32* %34, i64 %idxprom19, !dbg !106
  %36 = load i32, i32* %arrayidx20, align 4, !dbg !106
  %37 = load i32, i32* %i8, align 4, !dbg !108
  %mul21 = mul nsw i32 %37, 16, !dbg !109
  %38 = load i32, i32* %j9, align 4, !dbg !110
  %add22 = add nsw i32 %mul21, %38, !dbg !111
  %idxprom23 = sext i32 %add22 to i64, !dbg !112
  %arrayidx24 = getelementptr inbounds [256 x i32], [256 x i32]* %B, i64 0, i64 %idxprom23, !dbg !112
  store i32 %36, i32* %arrayidx24, align 4, !dbg !113
  br label %for.inc25, !dbg !114

for.inc25:                                        ; preds = %if.end18
  %39 = load i32, i32* %itr7, align 4, !dbg !115
  %inc26 = add nsw i32 %39, 1, !dbg !115
  store i32 %inc26, i32* %itr7, align 4, !dbg !115
  %40 = load i32, i32* %j9, align 4, !dbg !116
  %inc27 = add nsw i32 %40, 1, !dbg !116
  store i32 %inc27, i32* %j9, align 4, !dbg !116
  br label %for.cond10, !dbg !95, !llvm.loop !117

for.end28:                                        ; preds = %for.cond.cleanup13
  br label %loop2, !dbg !118

loop2:                                            ; preds = %for.end28
  %41 = bitcast i32* %x to i8*, !dbg !122
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %41) #5, !dbg !122
  call void @llvm.dbg.declare(metadata i32* %x, metadata !124, metadata !DIExpression()), !dbg !125
  store i32 0, i32* %x, align 4, !dbg !125
  br label %for.cond29, !dbg !122

for.cond29:                                       ; preds = %for.inc70, %loop2
  %42 = load i32, i32* %x, align 4, !dbg !126
  %43 = load i32, i32* %rep_count.addr, align 4, !dbg !128
  %cmp30 = icmp slt i32 %42, %43, !dbg !129
  br i1 %cmp30, label %for.body32, label %for.cond.cleanup31, !dbg !130

for.cond.cleanup31:                               ; preds = %for.cond29
  store i32 11, i32* %cleanup.dest.slot, align 4
  %44 = bitcast i32* %x to i8*, !dbg !131
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %44) #5, !dbg !131
  br label %for.end72

for.body32:                                       ; preds = %for.cond29
  br label %lreorder1, !dbg !132

lreorder1:                                        ; preds = %for.body32
  %45 = bitcast i32* %i33 to i8*, !dbg !133
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %45) #5, !dbg !133
  call void @llvm.dbg.declare(metadata i32* %i33, metadata !136, metadata !DIExpression()), !dbg !137
  store i32 0, i32* %i33, align 4, !dbg !137
  br label %for.cond34, !dbg !133

for.cond34:                                       ; preds = %for.inc67, %lreorder1
  %46 = load i32, i32* %i33, align 4, !dbg !138
  %47 = load i32, i32* %dim.addr, align 4, !dbg !140
  %cmp35 = icmp slt i32 %46, %47, !dbg !141
  br i1 %cmp35, label %for.body37, label %for.cond.cleanup36, !dbg !142

for.cond.cleanup36:                               ; preds = %for.cond34
  store i32 15, i32* %cleanup.dest.slot, align 4
  %48 = bitcast i32* %i33 to i8*, !dbg !143
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %48) #5, !dbg !143
  br label %for.end69

for.body37:                                       ; preds = %for.cond34
  br label %lreorder2, !dbg !144

lreorder2:                                        ; preds = %for.body37
  %49 = bitcast i32* %j38 to i8*, !dbg !145
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %49) #5, !dbg !145
  call void @llvm.dbg.declare(metadata i32* %j38, metadata !148, metadata !DIExpression()), !dbg !149
  store i32 0, i32* %j38, align 4, !dbg !149
  br label %for.cond39, !dbg !145

for.cond39:                                       ; preds = %for.inc64, %lreorder2
  %50 = load i32, i32* %j38, align 4, !dbg !150
  %51 = load i32, i32* %dim.addr, align 4, !dbg !152
  %cmp40 = icmp slt i32 %50, %51, !dbg !153
  br i1 %cmp40, label %for.body42, label %for.cond.cleanup41, !dbg !154

for.cond.cleanup41:                               ; preds = %for.cond39
  store i32 19, i32* %cleanup.dest.slot, align 4
  %52 = bitcast i32* %j38 to i8*, !dbg !155
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %52) #5, !dbg !155
  br label %for.end66

for.body42:                                       ; preds = %for.cond39
  %53 = bitcast i32* %result to i8*, !dbg !156
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %53) #5, !dbg !156
  call void @llvm.dbg.declare(metadata i32* %result, metadata !158, metadata !DIExpression()), !dbg !159
  store i32 0, i32* %result, align 4, !dbg !159
  br label %lreorder3, !dbg !156

lreorder3:                                        ; preds = %for.body42
  %54 = bitcast i32* %k to i8*, !dbg !160
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %54) #5, !dbg !160
  call void @llvm.dbg.declare(metadata i32* %k, metadata !162, metadata !DIExpression()), !dbg !163
  store i32 0, i32* %k, align 4, !dbg !163
  br label %for.cond43, !dbg !160

for.cond43:                                       ; preds = %for.inc57, %lreorder3
  %55 = load i32, i32* %k, align 4, !dbg !164
  %cmp44 = icmp slt i32 %55, 16, !dbg !166
  br i1 %cmp44, label %for.body46, label %for.cond.cleanup45, !dbg !167

for.cond.cleanup45:                               ; preds = %for.cond43
  store i32 23, i32* %cleanup.dest.slot, align 4
  %56 = bitcast i32* %k to i8*, !dbg !168
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %56) #5, !dbg !168
  br label %for.end59

for.body46:                                       ; preds = %for.cond43
  %57 = load i32, i32* %i33, align 4, !dbg !169
  %mul47 = mul nsw i32 %57, 16, !dbg !171
  %58 = load i32, i32* %k, align 4, !dbg !172
  %add48 = add nsw i32 %mul47, %58, !dbg !173
  %idxprom49 = sext i32 %add48 to i64, !dbg !174
  %arrayidx50 = getelementptr inbounds [256 x i32], [256 x i32]* %A, i64 0, i64 %idxprom49, !dbg !174
  %59 = load i32, i32* %arrayidx50, align 4, !dbg !174
  %60 = load i32, i32* %k, align 4, !dbg !175
  %mul51 = mul nsw i32 %60, 16, !dbg !176
  %61 = load i32, i32* %j38, align 4, !dbg !177
  %add52 = add nsw i32 %mul51, %61, !dbg !178
  %idxprom53 = sext i32 %add52 to i64, !dbg !179
  %arrayidx54 = getelementptr inbounds [256 x i32], [256 x i32]* %B, i64 0, i64 %idxprom53, !dbg !179
  %62 = load i32, i32* %arrayidx54, align 4, !dbg !179
  %mul55 = mul nsw i32 %59, %62, !dbg !180
  %63 = load i32, i32* %result, align 4, !dbg !181
  %add56 = add nsw i32 %63, %mul55, !dbg !181
  store i32 %add56, i32* %result, align 4, !dbg !181
  br label %for.inc57, !dbg !182

for.inc57:                                        ; preds = %for.body46
  %64 = load i32, i32* %k, align 4, !dbg !183
  %inc58 = add nsw i32 %64, 1, !dbg !183
  store i32 %inc58, i32* %k, align 4, !dbg !183
  br label %for.cond43, !dbg !168, !llvm.loop !184

for.end59:                                        ; preds = %for.cond.cleanup45
  %65 = load i32, i32* %result, align 4, !dbg !187
  %66 = load i32, i32* %i33, align 4, !dbg !188
  %mul60 = mul nsw i32 %66, 16, !dbg !189
  %67 = load i32, i32* %j38, align 4, !dbg !190
  %add61 = add nsw i32 %mul60, %67, !dbg !191
  %idxprom62 = sext i32 %add61 to i64, !dbg !192
  %arrayidx63 = getelementptr inbounds [256 x i32], [256 x i32]* %C, i64 0, i64 %idxprom62, !dbg !192
  store i32 %65, i32* %arrayidx63, align 4, !dbg !193
  %68 = bitcast i32* %result to i8*, !dbg !194
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %68) #5, !dbg !194
  br label %for.inc64, !dbg !195

for.inc64:                                        ; preds = %for.end59
  %69 = load i32, i32* %j38, align 4, !dbg !196
  %inc65 = add nsw i32 %69, 1, !dbg !196
  store i32 %inc65, i32* %j38, align 4, !dbg !196
  br label %for.cond39, !dbg !155, !llvm.loop !197

for.end66:                                        ; preds = %for.cond.cleanup41
  br label %for.inc67, !dbg !202

for.inc67:                                        ; preds = %for.end66
  %70 = load i32, i32* %i33, align 4, !dbg !203
  %inc68 = add nsw i32 %70, 1, !dbg !203
  store i32 %inc68, i32* %i33, align 4, !dbg !203
  br label %for.cond34, !dbg !143, !llvm.loop !204

for.end69:                                        ; preds = %for.cond.cleanup36
  br label %for.inc70, !dbg !209

for.inc70:                                        ; preds = %for.end69
  %71 = load i32, i32* %x, align 4, !dbg !210
  %inc71 = add nsw i32 %71, 1, !dbg !210
  store i32 %inc71, i32* %x, align 4, !dbg !210
  br label %for.cond29, !dbg !131, !llvm.loop !211

for.end72:                                        ; preds = %for.cond.cleanup31
  br label %writeC, !dbg !212

writeC:                                           ; preds = %for.end72
  %72 = bitcast i32* %itr73 to i8*, !dbg !216
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %72) #5, !dbg !216
  call void @llvm.dbg.declare(metadata i32* %itr73, metadata !218, metadata !DIExpression()), !dbg !219
  store i32 0, i32* %itr73, align 4, !dbg !219
  %73 = bitcast i32* %i74 to i8*, !dbg !216
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %73) #5, !dbg !216
  call void @llvm.dbg.declare(metadata i32* %i74, metadata !220, metadata !DIExpression()), !dbg !221
  store i32 0, i32* %i74, align 4, !dbg !221
  %74 = bitcast i32* %j75 to i8*, !dbg !216
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %74) #5, !dbg !216
  call void @llvm.dbg.declare(metadata i32* %j75, metadata !222, metadata !DIExpression()), !dbg !223
  store i32 0, i32* %j75, align 4, !dbg !223
  br label %for.cond76, !dbg !216

for.cond76:                                       ; preds = %for.inc91, %writeC
  %75 = load i32, i32* %itr73, align 4, !dbg !224
  %76 = load i32, i32* %dim.addr, align 4, !dbg !226
  %77 = load i32, i32* %dim.addr, align 4, !dbg !227
  %mul77 = mul nsw i32 %76, %77, !dbg !228
  %cmp78 = icmp slt i32 %75, %mul77, !dbg !229
  br i1 %cmp78, label %for.body80, label %for.cond.cleanup79, !dbg !230

for.cond.cleanup79:                               ; preds = %for.cond76
  store i32 27, i32* %cleanup.dest.slot, align 4
  %78 = bitcast i32* %j75 to i8*, !dbg !231
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %78) #5, !dbg !231
  %79 = bitcast i32* %i74 to i8*, !dbg !231
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %79) #5, !dbg !231
  %80 = bitcast i32* %itr73 to i8*, !dbg !231
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %80) #5, !dbg !231
  br label %for.end94

for.body80:                                       ; preds = %for.cond76
  %81 = load i32, i32* %j75, align 4, !dbg !232
  %82 = load i32, i32* %dim.addr, align 4, !dbg !235
  %cmp81 = icmp eq i32 %81, %82, !dbg !236
  br i1 %cmp81, label %if.then82, label %if.end84, !dbg !237

if.then82:                                        ; preds = %for.body80
  store i32 0, i32* %j75, align 4, !dbg !238
  %83 = load i32, i32* %i74, align 4, !dbg !240
  %inc83 = add nsw i32 %83, 1, !dbg !240
  store i32 %inc83, i32* %i74, align 4, !dbg !240
  br label %if.end84, !dbg !241

if.end84:                                         ; preds = %if.then82, %for.body80
  %84 = load i32, i32* %i74, align 4, !dbg !242
  %mul85 = mul nsw i32 %84, 16, !dbg !243
  %85 = load i32, i32* %j75, align 4, !dbg !244
  %add86 = add nsw i32 %mul85, %85, !dbg !245
  %idxprom87 = sext i32 %add86 to i64, !dbg !246
  %arrayidx88 = getelementptr inbounds [256 x i32], [256 x i32]* %C, i64 0, i64 %idxprom87, !dbg !246
  %86 = load i32, i32* %arrayidx88, align 4, !dbg !246
  %87 = load i32*, i32** %out_r.addr, align 8, !dbg !247
  %88 = load i32, i32* %itr73, align 4, !dbg !248
  %idxprom89 = sext i32 %88 to i64, !dbg !247
  %arrayidx90 = getelementptr inbounds i32, i32* %87, i64 %idxprom89, !dbg !247
  store i32 %86, i32* %arrayidx90, align 4, !dbg !249
  br label %for.inc91, !dbg !250

for.inc91:                                        ; preds = %if.end84
  %89 = load i32, i32* %itr73, align 4, !dbg !251
  %inc92 = add nsw i32 %89, 1, !dbg !251
  store i32 %inc92, i32* %itr73, align 4, !dbg !251
  %90 = load i32, i32* %j75, align 4, !dbg !252
  %inc93 = add nsw i32 %90, 1, !dbg !252
  store i32 %inc93, i32* %j75, align 4, !dbg !252
  br label %for.cond76, !dbg !231, !llvm.loop !253

for.end94:                                        ; preds = %for.cond.cleanup79
  %91 = bitcast [256 x i32]* %C to i8*, !dbg !258
  call void @llvm.lifetime.end.p0i8(i64 1024, i8* %91) #5, !dbg !258
  %92 = bitcast [256 x i32]* %B to i8*, !dbg !258
  call void @llvm.lifetime.end.p0i8(i64 1024, i8* %92) #5, !dbg !258
  %93 = bitcast [256 x i32]* %A to i8*, !dbg !258
  call void @llvm.lifetime.end.p0i8(i64 1024, i8* %93) #5, !dbg !258
  ret void, !dbg !258
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: inaccessiblememonly nounwind willreturn
declare void @llvm.sideeffect() #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #3

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "fpga.demangled.name"="matmul_partition" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { inaccessiblememonly nounwind willreturn }
attributes #3 = { argmemonly nounwind willreturn }
attributes #4 = { inaccessiblememonly nounwind "xlx.port.bitwidth"="0" "xlx.source"="user" }
attributes #5 = { nounwind }
attributes #6 = { inaccessiblememonly nounwind "xlx.port.bitwidth"="8192" "xlx.source"="user" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 7.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "third_party/Vitis-HLS-Introductory-Examples/Array/array_partition_block_cyclic/matmul_partition.cpp", directory: "/data/hls-dev")
!2 = !{}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{!"clang version 7.0.0 "}
!6 = distinct !DISubprogram(name: "matmul_partition", linkageName: "_Z16matmul_partitionPiS_S_ii", scope: !1, file: !1, line: 24, type: !7, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{null, !9, !9, !9, !10, !10}
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "in1", arg: 1, scope: !6, file: !1, line: 24, type: !9)
!12 = !DILocation(line: 24, column: 28, scope: !6)
!13 = !DILocalVariable(name: "in2", arg: 2, scope: !6, file: !1, line: 24, type: !9)
!14 = !DILocation(line: 24, column: 38, scope: !6)
!15 = !DILocalVariable(name: "out_r", arg: 3, scope: !6, file: !1, line: 24, type: !9)
!16 = !DILocation(line: 24, column: 48, scope: !6)
!17 = !DILocalVariable(name: "dim", arg: 4, scope: !6, file: !1, line: 24, type: !10)
!18 = !DILocation(line: 24, column: 59, scope: !6)
!19 = !DILocalVariable(name: "rep_count", arg: 5, scope: !6, file: !1, line: 24, type: !10)
!20 = !DILocation(line: 24, column: 68, scope: !6)
!21 = !DILocation(line: 25, column: 9, scope: !6)
!22 = !DILocation(line: 26, column: 9, scope: !6)
!23 = !DILocation(line: 27, column: 9, scope: !6)
!24 = !DILocation(line: 29, column: 5, scope: !6)
!25 = !DILocalVariable(name: "A", scope: !6, file: !1, line: 29, type: !26)
!26 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 8192, elements: !27)
!27 = !{!28}
!28 = !DISubrange(count: 256)
!29 = !DILocation(line: 29, column: 9, scope: !6)
!30 = !DILocation(line: 30, column: 5, scope: !6)
!31 = !DILocalVariable(name: "B", scope: !6, file: !1, line: 30, type: !26)
!32 = !DILocation(line: 30, column: 9, scope: !6)
!33 = !DILocation(line: 31, column: 5, scope: !6)
!34 = !DILocalVariable(name: "C", scope: !6, file: !1, line: 31, type: !26)
!35 = !DILocation(line: 31, column: 9, scope: !6)
!36 = !DILocation(line: 34, column: 9, scope: !6)
!37 = !DILocation(line: 37, column: 9, scope: !6)
!38 = !DILocation(line: 46, column: 10, scope: !39)
!39 = distinct !DILexicalBlock(scope: !6, file: !1, line: 46, column: 5)
!40 = !DILocalVariable(name: "itr", scope: !39, file: !1, line: 46, type: !10)
!41 = !DILocation(line: 46, column: 14, scope: !39)
!42 = !DILocalVariable(name: "i", scope: !39, file: !1, line: 46, type: !10)
!43 = !DILocation(line: 46, column: 23, scope: !39)
!44 = !DILocalVariable(name: "j", scope: !39, file: !1, line: 46, type: !10)
!45 = !DILocation(line: 46, column: 30, scope: !39)
!46 = !DILocation(line: 46, column: 37, scope: !47)
!47 = distinct !DILexicalBlock(scope: !39, file: !1, line: 46, column: 5)
!48 = !DILocation(line: 46, column: 43, scope: !47)
!49 = !DILocation(line: 46, column: 49, scope: !47)
!50 = !DILocation(line: 46, column: 47, scope: !47)
!51 = !DILocation(line: 46, column: 41, scope: !47)
!52 = !DILocation(line: 46, column: 5, scope: !39)
!53 = !DILocation(line: 46, column: 5, scope: !47)
!54 = !DILocation(line: 48, column: 13, scope: !55)
!55 = distinct !DILexicalBlock(scope: !56, file: !1, line: 48, column: 13)
!56 = distinct !DILexicalBlock(scope: !47, file: !1, line: 46, column: 66)
!57 = !DILocation(line: 48, column: 18, scope: !55)
!58 = !DILocation(line: 48, column: 15, scope: !55)
!59 = !DILocation(line: 48, column: 13, scope: !56)
!60 = !DILocation(line: 49, column: 15, scope: !61)
!61 = distinct !DILexicalBlock(scope: !55, file: !1, line: 48, column: 23)
!62 = !DILocation(line: 50, column: 14, scope: !61)
!63 = !DILocation(line: 51, column: 9, scope: !61)
!64 = !DILocation(line: 52, column: 30, scope: !56)
!65 = !DILocation(line: 52, column: 34, scope: !56)
!66 = !DILocation(line: 52, column: 11, scope: !56)
!67 = !DILocation(line: 52, column: 13, scope: !56)
!68 = !DILocation(line: 52, column: 25, scope: !56)
!69 = !DILocation(line: 52, column: 23, scope: !56)
!70 = !DILocation(line: 52, column: 9, scope: !56)
!71 = !DILocation(line: 52, column: 28, scope: !56)
!72 = !DILocation(line: 53, column: 5, scope: !56)
!73 = !DILocation(line: 46, column: 57, scope: !47)
!74 = !DILocation(line: 46, column: 62, scope: !47)
!75 = distinct !{!75, !52, !76, !77, !78}
!76 = !DILocation(line: 53, column: 5, scope: !39)
!77 = !{!"llvm.loop.name", !"readA"}
!78 = !{!"llvm.loop.tripcount", i32 256, i32 256, i32 256, !"user", !79}
!79 = !DILocation(line: 47, column: 9, scope: !39)
!80 = !DILocation(line: 57, column: 10, scope: !81)
!81 = distinct !DILexicalBlock(scope: !6, file: !1, line: 57, column: 5)
!82 = !DILocalVariable(name: "itr", scope: !81, file: !1, line: 57, type: !10)
!83 = !DILocation(line: 57, column: 14, scope: !81)
!84 = !DILocalVariable(name: "i", scope: !81, file: !1, line: 57, type: !10)
!85 = !DILocation(line: 57, column: 23, scope: !81)
!86 = !DILocalVariable(name: "j", scope: !81, file: !1, line: 57, type: !10)
!87 = !DILocation(line: 57, column: 30, scope: !81)
!88 = !DILocation(line: 57, column: 37, scope: !89)
!89 = distinct !DILexicalBlock(scope: !81, file: !1, line: 57, column: 5)
!90 = !DILocation(line: 57, column: 43, scope: !89)
!91 = !DILocation(line: 57, column: 49, scope: !89)
!92 = !DILocation(line: 57, column: 47, scope: !89)
!93 = !DILocation(line: 57, column: 41, scope: !89)
!94 = !DILocation(line: 57, column: 5, scope: !81)
!95 = !DILocation(line: 57, column: 5, scope: !89)
!96 = !DILocation(line: 59, column: 13, scope: !97)
!97 = distinct !DILexicalBlock(scope: !98, file: !1, line: 59, column: 13)
!98 = distinct !DILexicalBlock(scope: !89, file: !1, line: 57, column: 66)
!99 = !DILocation(line: 59, column: 18, scope: !97)
!100 = !DILocation(line: 59, column: 15, scope: !97)
!101 = !DILocation(line: 59, column: 13, scope: !98)
!102 = !DILocation(line: 60, column: 15, scope: !103)
!103 = distinct !DILexicalBlock(scope: !97, file: !1, line: 59, column: 23)
!104 = !DILocation(line: 61, column: 14, scope: !103)
!105 = !DILocation(line: 62, column: 9, scope: !103)
!106 = !DILocation(line: 63, column: 30, scope: !98)
!107 = !DILocation(line: 63, column: 34, scope: !98)
!108 = !DILocation(line: 63, column: 11, scope: !98)
!109 = !DILocation(line: 63, column: 13, scope: !98)
!110 = !DILocation(line: 63, column: 25, scope: !98)
!111 = !DILocation(line: 63, column: 23, scope: !98)
!112 = !DILocation(line: 63, column: 9, scope: !98)
!113 = !DILocation(line: 63, column: 28, scope: !98)
!114 = !DILocation(line: 64, column: 5, scope: !98)
!115 = !DILocation(line: 57, column: 57, scope: !89)
!116 = !DILocation(line: 57, column: 62, scope: !89)
!117 = distinct !{!117, !94, !118, !119, !120}
!118 = !DILocation(line: 64, column: 5, scope: !81)
!119 = !{!"llvm.loop.name", !"readB"}
!120 = !{!"llvm.loop.tripcount", i32 256, i32 256, i32 256, !"user", !121}
!121 = !DILocation(line: 58, column: 9, scope: !81)
!122 = !DILocation(line: 67, column: 10, scope: !123)
!123 = distinct !DILexicalBlock(scope: !6, file: !1, line: 67, column: 5)
!124 = !DILocalVariable(name: "x", scope: !123, file: !1, line: 67, type: !10)
!125 = !DILocation(line: 67, column: 14, scope: !123)
!126 = !DILocation(line: 67, column: 21, scope: !127)
!127 = distinct !DILexicalBlock(scope: !123, file: !1, line: 67, column: 5)
!128 = !DILocation(line: 67, column: 25, scope: !127)
!129 = !DILocation(line: 67, column: 23, scope: !127)
!130 = !DILocation(line: 67, column: 5, scope: !123)
!131 = !DILocation(line: 67, column: 5, scope: !127)
!132 = !DILocation(line: 67, column: 41, scope: !127)
!133 = !DILocation(line: 70, column: 14, scope: !134)
!134 = distinct !DILexicalBlock(scope: !135, file: !1, line: 70, column: 9)
!135 = distinct !DILexicalBlock(scope: !127, file: !1, line: 67, column: 41)
!136 = !DILocalVariable(name: "i", scope: !134, file: !1, line: 70, type: !10)
!137 = !DILocation(line: 70, column: 18, scope: !134)
!138 = !DILocation(line: 70, column: 25, scope: !139)
!139 = distinct !DILexicalBlock(scope: !134, file: !1, line: 70, column: 9)
!140 = !DILocation(line: 70, column: 29, scope: !139)
!141 = !DILocation(line: 70, column: 27, scope: !139)
!142 = !DILocation(line: 70, column: 9, scope: !134)
!143 = !DILocation(line: 70, column: 9, scope: !139)
!144 = !DILocation(line: 70, column: 39, scope: !139)
!145 = !DILocation(line: 75, column: 18, scope: !146)
!146 = distinct !DILexicalBlock(scope: !147, file: !1, line: 75, column: 13)
!147 = distinct !DILexicalBlock(scope: !139, file: !1, line: 70, column: 39)
!148 = !DILocalVariable(name: "j", scope: !146, file: !1, line: 75, type: !10)
!149 = !DILocation(line: 75, column: 22, scope: !146)
!150 = !DILocation(line: 75, column: 29, scope: !151)
!151 = distinct !DILexicalBlock(scope: !146, file: !1, line: 75, column: 13)
!152 = !DILocation(line: 75, column: 33, scope: !151)
!153 = !DILocation(line: 75, column: 31, scope: !151)
!154 = !DILocation(line: 75, column: 13, scope: !146)
!155 = !DILocation(line: 75, column: 13, scope: !151)
!156 = !DILocation(line: 77, column: 17, scope: !157)
!157 = distinct !DILexicalBlock(scope: !151, file: !1, line: 75, column: 43)
!158 = !DILocalVariable(name: "result", scope: !157, file: !1, line: 77, type: !10)
!159 = !DILocation(line: 77, column: 21, scope: !157)
!160 = !DILocation(line: 79, column: 22, scope: !161)
!161 = distinct !DILexicalBlock(scope: !157, file: !1, line: 79, column: 17)
!162 = !DILocalVariable(name: "k", scope: !161, file: !1, line: 79, type: !10)
!163 = !DILocation(line: 79, column: 26, scope: !161)
!164 = !DILocation(line: 79, column: 33, scope: !165)
!165 = distinct !DILexicalBlock(scope: !161, file: !1, line: 79, column: 17)
!166 = !DILocation(line: 79, column: 35, scope: !165)
!167 = !DILocation(line: 79, column: 17, scope: !161)
!168 = !DILocation(line: 79, column: 17, scope: !165)
!169 = !DILocation(line: 81, column: 33, scope: !170)
!170 = distinct !DILexicalBlock(scope: !165, file: !1, line: 79, column: 51)
!171 = !DILocation(line: 81, column: 35, scope: !170)
!172 = !DILocation(line: 81, column: 47, scope: !170)
!173 = !DILocation(line: 81, column: 45, scope: !170)
!174 = !DILocation(line: 81, column: 31, scope: !170)
!175 = !DILocation(line: 81, column: 54, scope: !170)
!176 = !DILocation(line: 81, column: 56, scope: !170)
!177 = !DILocation(line: 81, column: 68, scope: !170)
!178 = !DILocation(line: 81, column: 66, scope: !170)
!179 = !DILocation(line: 81, column: 52, scope: !170)
!180 = !DILocation(line: 81, column: 50, scope: !170)
!181 = !DILocation(line: 81, column: 28, scope: !170)
!182 = !DILocation(line: 82, column: 17, scope: !170)
!183 = !DILocation(line: 79, column: 47, scope: !165)
!184 = distinct !{!184, !167, !185, !186}
!185 = !DILocation(line: 82, column: 17, scope: !161)
!186 = !{!"llvm.loop.name", !"lreorder3"}
!187 = !DILocation(line: 83, column: 38, scope: !157)
!188 = !DILocation(line: 83, column: 19, scope: !157)
!189 = !DILocation(line: 83, column: 21, scope: !157)
!190 = !DILocation(line: 83, column: 33, scope: !157)
!191 = !DILocation(line: 83, column: 31, scope: !157)
!192 = !DILocation(line: 83, column: 17, scope: !157)
!193 = !DILocation(line: 83, column: 36, scope: !157)
!194 = !DILocation(line: 84, column: 13, scope: !151)
!195 = !DILocation(line: 84, column: 13, scope: !157)
!196 = !DILocation(line: 75, column: 39, scope: !151)
!197 = distinct !{!197, !154, !198, !199, !200}
!198 = !DILocation(line: 84, column: 13, scope: !146)
!199 = !{!"llvm.loop.name", !"lreorder2"}
!200 = !{!"llvm.loop.tripcount", i32 16, i32 16, i32 16, !"user", !201}
!201 = !DILocation(line: 76, column: 9, scope: !146)
!202 = !DILocation(line: 85, column: 9, scope: !147)
!203 = !DILocation(line: 70, column: 35, scope: !139)
!204 = distinct !{!204, !142, !205, !206, !207}
!205 = !DILocation(line: 85, column: 9, scope: !134)
!206 = !{!"llvm.loop.name", !"lreorder1"}
!207 = !{!"llvm.loop.tripcount", i32 16, i32 16, i32 16, !"user", !208}
!208 = !DILocation(line: 71, column: 9, scope: !134)
!209 = !DILocation(line: 86, column: 5, scope: !135)
!210 = !DILocation(line: 67, column: 37, scope: !127)
!211 = distinct !{!211, !130, !212, !213, !214}
!212 = !DILocation(line: 86, column: 5, scope: !123)
!213 = !{!"llvm.loop.name", !"loop2"}
!214 = !{!"llvm.loop.tripcount", i32 1, i32 1, i32 1, !"user", !215}
!215 = !DILocation(line: 68, column: 9, scope: !123)
!216 = !DILocation(line: 91, column: 10, scope: !217)
!217 = distinct !DILexicalBlock(scope: !6, file: !1, line: 91, column: 5)
!218 = !DILocalVariable(name: "itr", scope: !217, file: !1, line: 91, type: !10)
!219 = !DILocation(line: 91, column: 14, scope: !217)
!220 = !DILocalVariable(name: "i", scope: !217, file: !1, line: 91, type: !10)
!221 = !DILocation(line: 91, column: 23, scope: !217)
!222 = !DILocalVariable(name: "j", scope: !217, file: !1, line: 91, type: !10)
!223 = !DILocation(line: 91, column: 30, scope: !217)
!224 = !DILocation(line: 91, column: 37, scope: !225)
!225 = distinct !DILexicalBlock(scope: !217, file: !1, line: 91, column: 5)
!226 = !DILocation(line: 91, column: 43, scope: !225)
!227 = !DILocation(line: 91, column: 49, scope: !225)
!228 = !DILocation(line: 91, column: 47, scope: !225)
!229 = !DILocation(line: 91, column: 41, scope: !225)
!230 = !DILocation(line: 91, column: 5, scope: !217)
!231 = !DILocation(line: 91, column: 5, scope: !225)
!232 = !DILocation(line: 93, column: 13, scope: !233)
!233 = distinct !DILexicalBlock(scope: !234, file: !1, line: 93, column: 13)
!234 = distinct !DILexicalBlock(scope: !225, file: !1, line: 91, column: 66)
!235 = !DILocation(line: 93, column: 18, scope: !233)
!236 = !DILocation(line: 93, column: 15, scope: !233)
!237 = !DILocation(line: 93, column: 13, scope: !234)
!238 = !DILocation(line: 94, column: 15, scope: !239)
!239 = distinct !DILexicalBlock(scope: !233, file: !1, line: 93, column: 23)
!240 = !DILocation(line: 95, column: 14, scope: !239)
!241 = !DILocation(line: 96, column: 9, scope: !239)
!242 = !DILocation(line: 97, column: 24, scope: !234)
!243 = !DILocation(line: 97, column: 26, scope: !234)
!244 = !DILocation(line: 97, column: 38, scope: !234)
!245 = !DILocation(line: 97, column: 36, scope: !234)
!246 = !DILocation(line: 97, column: 22, scope: !234)
!247 = !DILocation(line: 97, column: 9, scope: !234)
!248 = !DILocation(line: 97, column: 15, scope: !234)
!249 = !DILocation(line: 97, column: 20, scope: !234)
!250 = !DILocation(line: 98, column: 5, scope: !234)
!251 = !DILocation(line: 91, column: 57, scope: !225)
!252 = !DILocation(line: 91, column: 62, scope: !225)
!253 = distinct !{!253, !230, !254, !255, !256}
!254 = !DILocation(line: 98, column: 5, scope: !217)
!255 = !{!"llvm.loop.name", !"writeC"}
!256 = !{!"llvm.loop.tripcount", i32 256, i32 256, i32 256, !"user", !257}
!257 = !DILocation(line: 92, column: 9, scope: !217)
!258 = !DILocation(line: 99, column: 1, scope: !6)
