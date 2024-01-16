#include <objc/runtime.h>
#include <objc/message.h>

#include <jni.h>

#define JNF_COCOA_ENTER(env)
#define JNF_COCOA_EXIT(env)

static inline NSString* JNFJavaToNSString(JNIEnv* env, jstring str) {
    NSString *result = NULL;
    const char *str_cstr = (*env)->GetStringUTFChars(env, str, 0);
    if ((*env)->ExceptionOccurred(env)) { return 0; }

    if (str_cstr != NULL) {
        result = @(str_cstr);
        (*env)->ReleaseStringUTFChars(env, str, str_cstr);
    }

    return result;
}
