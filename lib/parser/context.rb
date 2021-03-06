# frozen_string_literal: true

module Parser
  # Context of parsing that is represented by a stack of scopes.
  #
  # Supported states:
  # + :class - in the class body (class A; end)
  # + :sclass - in the singleton class body (class << obj; end)
  # + :def - in the method body (def m; end)
  # + :defs - in the singleton method body (def self.m; end)
  # + :block - in the block body (tap {})
  # + :lambda - in the lambda body (-> {})
  #
  class Context
    attr_reader :stack

    def initialize
      @stack = []
      freeze
    end

    def push(state)
      @stack << state
    end

    def pop
      @stack.pop
    end

    def reset
      @stack.clear
    end

    def in_class?
      @stack.last == :class
    end

    def indirectly_in_def?
      @stack.include?(:def) || @stack.include?(:defs)
    end
  end
end
