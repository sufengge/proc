TARGET = mytest



SRC_DIR = /home/sufg/proc/src
BIN_DIR = /home/sufg/proc/bin
SRC_SUBDIR += .
INCLUDE_DIR += /home/sufg/proc/include/
IIBDIR += /home/sufg/proc/lib/
LIBNAME += mytest
OBJ_DIR = /home/sufg/proc/OBJ/



CC = gcc
C_FLAGS = -g -Wall
LD = $(CC)
INCLUDES += -I$(INCLUDE_DIR)
LD_FLAFS += -L$(IIBDIR)
LD_LIBS += -l$(LIBNAME)

ifeq ($(CC), g++)
	    TYPE = cpp
    else
	    TYPE = c
    endif

SRCS += ${foreach subdir, $(SRC_SUBDIR), ${wildcard $(SRC_DIR)/$(subdir)/*.$(TYPE)}}
OBJS += ${foreach src, $(notdir $(SRCS)), ${patsubst %.$(TYPE), $(OBJ_DIR)/%.o, $(src)}}

vpath %.$(TYPE) $(sort $(dir $(SRCS)))

all : $(TARGET)
	    @echo "Builded target:" $^
	    @echo "Done"
		mv $^ $(BIN_DIR)

$(TARGET) : $(OBJS)
	    @mkdir -p $(@D)
		@echo "Linking" $@ "from" $^ "..."
		$(LD) -o $@ $^ $(LD_FLAGS) $(LD_FLAFS) $(LD_LIBS)
		@echo "Link finished\n"

$(OBJS) : $(OBJ_DIR)/%.o:%.$(TYPE)
	    @mkdir -p $(@D)
		@echo "Compiling" $@ "from" $< "..."
		$(CC) -c -o $@ $< $(C_FLAGS) $(INCLUDES)
		@echo "==================Compile [$^] finished!=================\n"

.PHONY : clean cleanobj
clean : cleanobj
	    @echo "Remove all executable files"
		rm -f $(TARGET)
cleanobj :
	    @echo "Remove object files"
		rm -rf $(OBJ_DIR)/*.o
