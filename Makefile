TARGET = pestilence

CC = gcc
CFLAGS = -Werror -Wextra -Werror

AS = nasm
ASFLAGS = -f elf64 -I ./inc/

LDFLAGS = -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc

RM = rm -f

#SRC_C = $(wildcard src/*.c)
SRC_A = $(wildcard src/*.s)
#OBJS = $(SRC_C:.c=.o)
OBJS += $(SRC_A:.s=.o)

all: $(TARGET)

$(TARGET) : $(OBJS)
	ld $^ -o $(TARGET)
#$(LDFLAGS)

#%.o: %.c
#	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(TARGET)

re: fclean all

test: re
	gcc ./test/hello.c -o /tmp/test/hello
	strings /tmp/test/hello | grep "hello"
	./pestilence
	strings /tmp/test/hello | grep "pestilence"

.PHONY: all clean fclean re test