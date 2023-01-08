#include <iostream>
#include <cstdlib>
#include "jsoncpp/json/json.h"

int main() {
#ifdef _WIN32
    system("chcp 65001");
#endif

    Json::Value root;
    root["name"] = "编程";
    root["score"] = 98;
    root["type"] = Json::nullValue;

    /* styled */
    std::cout << "styled" << std::endl;
    {
        Json::Value settings;
        settings["emitUTF8"] = false;
        settings["indentation"] = "    ";
        std::cout << root.toStyledString(settings) << std::endl;
    }

    /* styled */
    std::cout << "styled, emitUTF8" << std::endl;
    {
        Json::Value settings;
        settings["emitUTF8"] = true;  // default
        settings["indentation"] = "    ";
        std::cout << root.toStyledString(settings) << std::endl;
    }

    /* not styled, faster */
    std::cout << "faster, emitUTF8" << std::endl;
    {
        Json::FastWriter fw;
        fw.emitUTF8();
        fw.omitEndingLineFeed();
        std::cout << fw.write(root) << std::endl;
        std::cout << std::endl;
    }

    /* not styled, faster, utf8 */
    std::cout << "faster, emitUTF8, dropNullKeyValues" << std::endl;
    {
        Json::FastWriter fw;
        fw.emitUTF8();
        fw.dropNullKeyValues();
        fw.omitEndingLineFeed();
        std::cout << fw.write(root) << std::endl;
        std::cout << std::endl;
    }

#ifdef _WIN32
    system("pause");
#endif

    return 0;
}
