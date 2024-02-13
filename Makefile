# ---------------------------------------------------- #
# SINGLE-HEADER TERMINAL USER INTERFACE | VARIATION-UI #
#          SHARED-LIBRARY CONVERTING MAKEFILE          #
# ---------------------------------------------------- #

CC = clang
ANSI = -std=c89
COMPILE_FLAGS = $(ANSI) -Wall

SOURCES = $(shell find ./src/ -name '*.c')
OBJECTS = $(addprefix ./out/objects/,$(SOURCES:./src/%.c=%.o))
HEADER_DIR = include/

SHARED = out/libvn_ui.so
STATIC = out/vn_ui.a

.PHONY: help shared clean install uninstall

help:
	@echo -e ""
	@echo -e "\t\t\033[38;2;55;55;200m[\033[38;2;233;233;233mMake List\033[38;2;55;55;200m]"
	@echo -e "\033[0m"
	@echo -e "\033[38;2;55;200;55m1.\033[38;2;233;233;233m Show make list \033[38;2;200;55;55m\033[1m'make' or 'make run'\033[0m"
	@echo -e "\033[38;2;55;200;55m2.\033[38;2;233;233;233m Compile as shared-library \033[38;2;200;55;55m\033[1m'make compile'\033[0m"
	@echo -e "\033[38;2;55;200;55m3.\033[38;2;233;233;233m Clean shared-library \033[38;2;200;55;55m\033[1m'make clean'\033[0m"
	@echo -e "\033[38;2;55;200;55m4.\033[38;2;233;233;233m Install the library \033[38;2;200;55;55m\033[1m'make install'\033[0m"
	@echo -e "\033[38;2;55;200;55m5.\033[38;2;233;233;233m Uninstall the library \033[38;2;200;55;55m\033[1m'make uninstall'\033[0m"
	@echo -e ""

./out/objects/%.o: ./src/%.c
	$(CC) $(COMPILE_FLAGS) -I$(HEADER_DIR) -c -o $@ $<

static: $(OBJECTS)
	ar rcs $(STATIC) $(OBJECTS)
	@echo -e ""
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m ------------------------------------- \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[ \033[38;2;200;55;55m\033[4mStatic-Library\033[0m\033[38;2;233;233;233m successfully compiled! \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m ------------------------------------- \033[38;2;55;200;55m] "
	@echo -e "\033[0m"

shared: $(OBJECTS)
	@$(CC) $(COMPILE_FLAGS) -shared -fPIC -o $(SHARED) $(OBJECTS)
	@echo -e ""
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m ------------------------------------- \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[ \033[38;2;200;55;55m\033[4mShared-Library\033[0m\033[38;2;233;233;233m successfully compiled! \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m ------------------------------------- \033[38;2;55;200;55m] "
	@echo -e "\033[0m"

clean:
	@rm $(SHARED)
	@echo -e ""
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m ------------------------------------ \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[ \033[38;2;200;55;55m\033[4mShared-Library\033[0m\033[38;2;233;233;233m successfully cleaned! \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m ------------------------------------ \033[38;2;55;200;55m] "
	@echo -e "\033[0m"

install: $(lib)
	@sudo mkdir -p /usr/include/vn
	@sudo cp ./include/*.h /usr/include/vn/
	@sudo chmod -x /usr/include/vn/*.h
	@echo -e ""
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m ------------------------------------ \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[ \033[38;2;200;55;55m\033[4mVariation UI\033[0m\033[38;2;233;233;233m successfully installed! \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m ------------------------------------ \033[38;2;55;200;55m] "
	@echo -e "\033[0m"

uninstall:
	@sudo rm /usr/include/vn/vn_ui.h
	@if [ "$(ls -A "/usr/include/vn/" 2> /dev/null)" = "" ]; then sudo rm -rf /usr/include/vn/; fi
	@echo -e ""
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m -------------------------------------- \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[ \033[38;2;200;55;55m\033[4mVariation UI\033[0m\033[38;2;233;233;233m successfully uninstalled! \033[38;2;55;200;55m] "
	@echo -e "\t\033[38;2;55;200;55m[\033[38;2;55;55;200m -------------------------------------- \033[38;2;55;200;55m] "
	@echo -e "\033[0m"

# MADE BY @hanilr #